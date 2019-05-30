class InlineErrorsFormBuilder < ActionView::Helpers::FormBuilder
  ERROR_CSS_CLASS = 'is-danger'.freeze

  def text_field(method, options = {})
    if attribute_has_error?(method)
      options[:class] = css_classes_with_error(options[:class])
    end

    super(method, options)
  end

  def password_field(method, options = {})
    if attribute_has_error?(method)
      options[:class] = css_classes_with_error(options[:class])
    end

    super(method, options)
  end

  def errors_for(attribute)
    return unless attribute_has_error?(attribute)

    @template.content_tag(:p, class: ['help', ERROR_CSS_CLASS]) do
      object.errors.full_messages_for(attribute).join(', ')
    end
  end

  private

  # Adds ERROR_CSS_CLASS to a list of CSS classes for the element
  def css_classes_with_error(css_classes)
    if css_classes.is_a?(Array)
      css_classes << ERROR_CSS_CLASS
    elsif css_classes.is_a?(String)
      css_classes << " #{ERROR_CSS_CLASS}"
    else
      ERROR_CSS_CLASS
    end
  end

  def attribute_has_error?(attribute)
    object.present? && object.errors.include?(attribute)
  end
end
