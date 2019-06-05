module ApplicationHelper
  FLASH_LEVEL_CSS_CLASS = {
    'alert' => 'is-danger',
    'notice' => 'is-primary'
  }.freeze

  def flash_messages
    flash.map do |level, message|
      level_css_class = FLASH_LEVEL_CSS_CLASS[level]

      content_tag(:div, class: ['notification', 'js-notification', level_css_class]) do
        concat button_tag(class: ['delete', 'js-notification-close'])
        concat message
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

  def header_buttons
    @header_buttons ||= []
  end

  def header_button(icon, link)
    header_buttons << OpenStruct.new(icon: icon, link: link)
  end

  def breadcrumbs
    @breadcrumbs ||= []
  end

  def breadcrumb(title, link = false)
    breadcrumbs << OpenStruct.new(title: title, link: link)
  end
end
