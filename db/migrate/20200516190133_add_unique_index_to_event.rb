# frozen_string_literal: true

class AddUniqueIndexToEvent < ActiveRecord::Migration[5.2]
  def change
    add_index :events, %i[g_id calendar_id], unique: true
  end
end
