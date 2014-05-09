require "spec_helper"

describe FeedsController do

  before(:each) { sign_in create(:user) }

  context "#create" do

    it "creates a new feed with valid parameters" do
      post :create, feed: {
        :name => "Example Feed",
        :url  => "http://www.marco.org/rss",
      }

      expect(assigns[:feed]).to be_valid
    end

  end

end
