# frozen_string_literal: true

class Calendar < ApplicationRecord
  validates :g_id, presence: true
  validates :g_id, uniqueness: { scope: :user_id }

  has_many :events, dependent: :destroy
  belongs_to :user
end
