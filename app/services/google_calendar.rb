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
end
