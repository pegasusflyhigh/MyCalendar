# frozen_string_literal: true

class SyncFullDataWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find user_id
    service = GoogleCalendar.new(user)
    raise 'error!' unless service.sync_data
  end
end
