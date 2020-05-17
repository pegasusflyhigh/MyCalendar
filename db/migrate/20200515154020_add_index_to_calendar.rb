# frozen_string_literal: true

class AddIndexToCalendar < ActiveRecord::Migration[5.2]
  def change
    add_index :calendars, %i[g_id user_id], unique: true
  end
end
