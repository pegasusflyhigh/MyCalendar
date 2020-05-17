# frozen_string_literal: true

class Event < ApplicationRecord
  STATUS = %w[confirmed tentative cancelled].freeze

  belongs_to :calendar
  validates :summary, presence: true
  validates :g_id, uniqueness: { scope: :calendar_id }, presence: true
  validates :status, inclusion: { in: STATUS }

  scope :active, -> { where('status != ?', 'cancelled') }
end
