# frozen_string_literal: true

class Event < ApplicationRecord
  STATUS = %w[confirmed tentative cancelled].freeze

  belongs_to :calendar
  validates :summary, presence: true
  validates :g_id, uniqueness: { scope: :calendar_id }, presence: true
  validates :status, inclusion: { in: STATUS }

  scope :active, -> { where('status != ?', 'cancelled') }

  def self.sync_data(calendar_id, event_items)
    event_items.each do |item|
      event = find_or_initialize_by(g_id: item[:g_id], calendar_id: calendar_id)
      event.assign_attributes(item.except(:g_id))
      event.save
    end
  end

  def all_day_event?
    return unless start_time.try(:[], 'date').present? && end_time.try(:[], 'date').present?

    Date.parse(end_time.dig('date')) == Date.parse(start_time.dig('date')) + 1.day
  end
end
