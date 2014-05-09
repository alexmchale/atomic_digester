class InheritedResourceController < InheritedResources::Base

  include InheritedResources::DSL

  def resource_with_decoration
    resource_without_decoration.decorate
  rescue Draper::UninferrableDecoratorError
    resource_without_decoration
  end

  alias_method_chain :resource, :decoration

end
