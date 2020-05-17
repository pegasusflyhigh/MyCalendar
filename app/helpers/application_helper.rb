# frozen_string_literal: true

module ApplicationHelper
  def format_date_time(date_time, time_zone)
    return if date_time.blank?

    DateTime.strptime(date_time).in_time_zone(time_zone).strftime('%a, %b %d %Y, %H:%M:%S %Z')
  end

  def format_date(date)
    return if date.blank?

    Date.parse(date).strftime('%d %B %Y')
  end
end
