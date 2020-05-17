# frozen_string_literal: true

class AddGoogleAuthTokensToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :google_token
      t.string :google_refresh_token
      t.string :token_provider
      t.integer :google_token_expires_at
    end
  end
end
