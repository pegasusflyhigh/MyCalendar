# frozen_string_literal: true

class SessionsController < ApplicationController
  def google_auth
    auth_response = request.env['omniauth.auth']
    user = User.from_omniauth(auth_response)
    SyncFullDataWorker.new.perform(user.id)
    redirect_to root_path unless log_in(user)
    redirect_to calendars_index_path
  end

  def logout
    log_out
    redirect_to root_path
  end
end
