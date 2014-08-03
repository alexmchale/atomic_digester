class StoriesController < ApplicationController

  respond_to :json

  load_and_authorize_resource :user

  def index
    @user ||= current_user
    @stories = @user.stories.reverse
  end

end
