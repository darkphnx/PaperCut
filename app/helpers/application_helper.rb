module ApplicationHelper
  FLASH_LEVEL_CSS_CLASS = {
    'alert' => 'is-danger'
  }

  def show_flash_messages
    flash.map do |level, message|
      level_css_class = FLASH_LEVEL_CSS_CLASS[level]

      content_tag(:article, class: ['message', level_css_class]) do
        content_tag(:div, message, class: 'message-body')
      end
    end.join.html_safe
  end
end
