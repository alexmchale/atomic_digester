class InheritedResourceController < InheritedResources::Base

  include InheritedResources::DSL

  before_filter :authenticate_user!

end
