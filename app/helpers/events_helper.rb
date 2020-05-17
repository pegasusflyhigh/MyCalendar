# frozen_string_literal: true

module EventsHelper
  def format_event_date(event)
    return [true, format_date(event.start_time.try(:[], 'date'))] if event.all_day_event?

    start_date = format_date_time(event.start_time.try(:[], 'dateTime'),
                                  event.start_time.try(:[], 'timeZone'))
    end_date = format_date_time(event.end_time.try(:[], 'dateTime'),
                                event.end_time.try(:[], 'timeZone'))
    [false, start_date, end_date]
  end
end
