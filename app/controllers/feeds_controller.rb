class FeedsController < InheritedResourceController

  belongs_to :user, optional: true

  load_and_authorize_resource :user
  load_and_authorize_resource :feed

  before_filter -> { raise 'whops!' }

  protected

  def permitted_params
    params.permit(feed: %i(
      name
      url
    ))
  end

end
