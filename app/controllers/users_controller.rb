class UsersController < InheritedResourceController

  respond_to :json

  load_and_authorize_resource :user

end
