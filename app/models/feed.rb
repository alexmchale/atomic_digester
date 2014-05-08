class Feed < ActiveRecord::Base

  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true
  validates :user_id, presence: true

  def stories
    Feedjira::Feed.fetch_and_parse(url).entries
  end

end
