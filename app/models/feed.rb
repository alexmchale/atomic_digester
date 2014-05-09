class Feed < ActiveRecord::Base

  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true
  validates :user_id, presence: true
  validate :validate_feed_url

  def stories
    Feedjira::Feed.fetch_and_parse(url).entries
  end

  protected

  def validate_feed_url
    unless Feedjira::Feed.fetch_and_parse(url).respond_to? :entries
      errors[:url] << "doesn't seem to be a valid rss feed"
    end
  end

end
