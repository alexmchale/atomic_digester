require "spec_helper"

describe FeedsController do

  before(:each) { sign_in build(:user) }

  context "#create" do

    it "creates a new feed with valid parameters" do
      expect_any_instance_of(Feed).to receive(:create)

      post :create, feed: {
        :name => "Example Feed",
        :url  => "http://example.com/feed.rss",
      }

      expect(assigns[:feed]).to be_valid
    end

  end

end
