module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def decorated(objects, decorator_class = nil, &block)
    Array(objects).map do |object|
      if decorator_class == nil
        class_name = if object.respond_to?(:model_name) then object.model_name else object.class.name end
        decorator_name = "#{class_name}Decorator"
        decorator_name.constantize.new(object)
      else
        decorator_class.new(object)
      end
    end
  end

end
