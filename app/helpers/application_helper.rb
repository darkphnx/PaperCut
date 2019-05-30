module ApplicationHelper
  FLASH_LEVEL_CSS_CLASS = {
    'alert' => 'is-danger'
  }

  def flash_messages
    flash.map do |level, message|
      level_css_class = FLASH_LEVEL_CSS_CLASS[level]

      content_tag(:article, class: ['message', level_css_class]) do
        content_tag(:div, message, class: 'message-body')
      end
    end.join.html_safe
  end

  def page_title(title = nil)
    @page_title = title if title.present?
    @page_title
  end

  def page_subtitle(subtitle = nil)
    @page_subtitle = subtitle if subtitle.present?
    @page_subtitle
  end
end
