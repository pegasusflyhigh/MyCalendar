# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate

  def events
    @user = User.find_by(id: params[:user_id])
    @events = @user.events
  end
end
