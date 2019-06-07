class InlineErrorsFormBuilder < ActionView::Helpers::FormBuilder
  ERROR_CSS_CLASS = 'is-danger'.freeze

  # Add an error class to the following helpers if that attribute has an error present
  %I[text_field password_field email_field].each do |form_helper_name|
    define_method(form_helper_name) do |method, options|
      options ||= {}

      if attribute_has_error?(method)
        options[:class] = css_classes_with_error(options[:class])
      end

      super(method, options)
    end
  end

  def date_select(method, options = {}, html_options = {})
    options.reverse_merge!(field_name: method.to_s,
                           prefix: @object_name,
                           include_position: true,
                           start_year: Time.current.year)

    date_selector = ActionView::Helpers::DateTimeSelector.new(object.send(method), options, html_options)
    [
      @template.content_tag(:div, class: 'select') do
        date_selector.select_year
      end,
      @template.content_tag(:div, class: 'select') do
        date_selector.select_month
      end,
      @template.content_tag(:div, class: 'select') do
        date_selector.select_day
      end
    ].join(' ').html_safe
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
