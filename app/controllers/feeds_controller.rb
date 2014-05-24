class FeedsController < InheritedResourceController

  respond_to :html, :json

  belongs_to :user, optional: true

  load_and_authorize_resource :user
  load_and_authorize_resource :feed

  protected

  def permitted_params
    params.permit(feed: %i(
      name
      url
    ))
  end

end
