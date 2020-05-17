# frozen_string_literal: true

class CalendarsController < ApplicationController
  before_action :authenticate
  before_action :load_calendar, only: :events

  def index
    @calendars = current_user.calendars.as_json(only: filter_params)
  end

  def events
    @events = @calendar.events
  end

  private

  def filter_params
    %i[id summary bg_color fg_color]
  end

  def load_calendar
    @calendar = current_user.calendars.find_by(id: params[:calendar_id])
    redirect_to calendars_index_path unless @calendar
  end
end
