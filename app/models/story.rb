class Story

  attr_reader :feed, :raw

  delegate :published,
           :author,
           :title,
           :summary,
           :url,
    to: :raw

  def initialize(feed, raw)
    @feed = feed
    @raw  = raw
  end

  def content
    html = raw.content
  end

end
