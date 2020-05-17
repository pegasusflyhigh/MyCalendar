# frozen_string_literal: true

class Calendar < ApplicationRecord
  validates :g_id, presence: true
  validates :g_id, uniqueness: { scope: :user_id }

  has_many :events, dependent: :destroy
  belongs_to :user

  def self.sync_data(user_id, calendar_items)
    calendar_items.each do |item|
      calendar = find_or_initialize_by(g_id: item[:g_id], user_id: user_id)
      calendar.assign_attributes(item.except(:g_id))
      calendar.save
    end
  end
end
