# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  def authenticate
    redirect_to(root_path) if current_user.nil?
  end

  def current_user
    return if session[:user_id].blank?

    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session[:user_id] = nil
  end
end
