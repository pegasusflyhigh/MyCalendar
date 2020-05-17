# frozen_string_literal: true

class AddUserIdToCalendar < ActiveRecord::Migration[5.2]
  def change
    add_reference :calendars, :user, foreign_key: true
  end
end
