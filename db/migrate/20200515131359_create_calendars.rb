# frozen_string_literal: true

class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.string :g_id
      t.string :summary
      t.string :timezone
      t.string :fg_color
      t.string :bg_color
      t.string :g_next_sync_token
      t.timestamps
    end
  end
end
