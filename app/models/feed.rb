class Feed < ActiveRecord::Base

  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true
  validates :user_id, presence: true
  validate :validate_feed_url

  def stories
    # First check Redis to see if we get a cache hit.
    xml = $redis.get(cache_key)
    return Feedjira::Feed.parse(xml).entries if xml.present?

    # Then retrieve the XML from the server.
    xml = Feedjira::Feed.fetch_raw(url)

    # Make sure the XML is a String (indicating we got a response).
    raise Feedjira::NoParserAvailable unless xml.kind_of?(String)

    # Attempt to parse the XML.
    parsed = Feedjira::Feed.parse(xml)

    # Does the parsed result seem correct?
    raise Feedjira::NoParserAvailable unless parsed.respond_to?(:entries)

    # Cache the response and return it.
    $redis.setex(cache_key, cache_lifetime_seconds, xml)
    parsed.entries
  rescue Feedjira::NoParserAvailable
    # We got something in response that isn't parsable.
    $redis.setex(cache_key, cache_lifetime_seconds, YAML.dump(nil))
    return
  end

  def cache_lifetime_seconds
    15.minutes
  end

  def cache_key
    "feed_cache:#{ url }"
  end

  protected

  def validate_feed_url
    errors[:url] << "doesn't seem to be a valid rss feed" unless stories
  end

end
