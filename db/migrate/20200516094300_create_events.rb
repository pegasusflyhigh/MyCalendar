# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :g_id
      t.string :summary
      t.string :description
      t.string :status
      t.string :html_link
      t.jsonb :start_time, default: {}
      t.jsonb :end_time, default: {}
      t.string :location
      t.jsonb :creator, default: {}
      t.jsonb :organizer, default: {}
      t.references :calendar, foreign_key: true

      t.timestamps
    end
  end
end
