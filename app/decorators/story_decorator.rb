class StoryDecorator < Draper::Decorator

  delegate_all

  def published
    if object.published.present? && object.updated.present? && (object.updated - object.published).abs > 1.minute
      "#{object.published} (updated #{object.updated})"
    elsif object.published.present?
      object.published.to_s
    elsif object.updated.present?
      object.updated.to_s
    else
      "(unknown)"
    end
  end

end
