# frozen_string_literal: true

class GoogleCalendar
  include HTTParty
  include ActiveModel::Validations

  base_uri 'https://www.googleapis.com/calendar/v3'

  validates_presence_of :access_token, :user

  API_LIST = {
    calendar_list: '/users/me/calendarList',
    event_list: '/calendars/%{calendar_id}/events'
  }.freeze

  def initialize(user)
    @user = user
    @access_token = user.google_token_expired? ? user.refresh_google_token : user.google_token
  end

  def sync_data
    valid? &&
      sync_calendars &&
      sync_events
  end

  private

  attr_reader :access_token, :user

  def event_list(calendar_g_id, params = {})
    calendar_id = CGI.escape(calendar_g_id)
    fetch_response(format(API_LIST[:event_list], calendar_id: calendar_id) + "?#{params.try(:to_query)}")
  end

  def calendar_list(params = {})
    fetch_response(API_LIST[:calendar_list] + "?#{params.try(:to_query)}")
  end

  def sync_calendars(page_token = nil) # rubocop:disable Metrics/AbcSize
    calendar_list_response = calendar_list({ syncToken: user.g_next_sync_token, pageToken: page_token })
    return true if calendar_list_response[:items].blank?

    Calendar.sync_data(user.id, calendar_list_response[:items])
    sync_calendars(calendar_list_response[:nextPageToken]) if calendar_list_response[:nextPageToken]
    user.update(g_next_sync_token: calendar_list_response[:nextSyncToken]) if calendar_list_response[:nextSyncToken]
  end

  def sync_events(page_token = nil) # rubocop:disable Metrics/AbcSize
    user.calendars.each do |calendar|
      events_list_response = event_list(calendar.g_id, { syncToken: calendar.g_next_sync_token, pageToken: page_token })
      next if events_list_response[:items].blank?

      Event.sync_data(calendar.id, events_list_response[:items])
      sync_events(events_list_response[:nextPageToken]) if events_list_response[:nextPageToken]
      calendar.update(g_next_sync_token: events_list_response[:nextSyncToken]) if events_list_response[:nextSyncToken]
    end
  end

  def fetch_response(url)
    response = self.class.get(url, query_params)
    if response.code == 200
      items = filter_response_items(response) || []
      {
        nextPageToken: response.parsed_response['nextPageToken'],
        nextSyncToken: response.parsed_response['nextSyncToken'],
        items: items
      }
    elsif response.code == 410
      Rails.logger.error('Invalid sync token, clearing event store and re-syncing.')
      delete_sync_tokens
      sync_data
    end
  end

  def filter_response_items(response)
    response.parsed_response['items'].map do |item|
      case item['kind']
      when 'calendar#calendarListEntry'
        filter_calendar(item)
      when 'calendar#event'
        filter_event(item)
      end
    end
  end

  def filter_calendar(calendar)
    {
      g_id: calendar['id'],
      summary: calendar['summary'],
      timezone: calendar['timeZone'],
      bg_color: calendar['backgroundColor'],
      fg_color: calendar['foregroundColor']
    }
  end

  def filter_event(event)
    {
      g_id: event['id'],
      summary: event['summary'],
      html_link: event['htmlLink'],
      status: event['status'],
      description: event['description'],
      location: event['location'],
      start_time: event['start'],
      end_time: event['end'],
      creator: event['creator'],
      organizer: event['organizer']
    }
  end

  def query_params
    { headers: { 'Authorization' => "Bearer #{access_token}" } }
  end

  def delete_sync_tokens
    user.update(g_next_sync_token: nil)
    user.calendars.find_each { |calendar| calendar.update(g_next_sync_token: nil) }
  end
end
