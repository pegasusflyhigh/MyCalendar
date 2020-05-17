# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate

  def events
    @user = User.find_by(id: params[:user_id])
    @events = @user.events
  end

  def sync_now
    SyncFullDataWorker.new.perform(current_user.id)
    # Todo - check status of job, then notify user
    redirect_to calendars_index_path
  end
end
