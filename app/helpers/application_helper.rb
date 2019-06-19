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

  # Builds a pie chart representation of minutes in an hour
  def clock_chart_svg(minutes, options = {})
    options.reverse_merge!(class: '')

    minutes_proportion = minutes / 60.0

    title = pluralize(minutes, 'minute')

    content_tag(:figure, title: title) do
      content_tag(:svg, class: ['clock', options[:class]], alt: title, viewBox: '0 0 100 100') do
        circle_radius = 50
        circle_circumference = 2 * Math::PI * circle_radius
        stroke_circumference = minutes_proportion * circle_circumference

        content_tag(:circle, nil, r: circle_radius, cx: 50, cy: 50, class: 'clock-face',
                                  style: "stroke-dasharray: #{stroke_circumference} #{circle_circumference}")
      end
    end
  end

  SHORTLIST_STATUS_COLOURS = {
    'invited' => 'is-warning',
    'backup' => 'is-dark',
    'accepted' => 'is-primary',
    'unavailable' => 'is-danger'
  }.freeze

  def shortlist_status_class(status)
    SHORTLIST_STATUS_COLOURS[status]
  end
end
