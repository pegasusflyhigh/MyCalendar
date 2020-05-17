# frozen_string_literal: true

class User < ApplicationRecord
  has_many :calendars, dependent: :destroy
  has_many :events, through: :calendars

  validates :email, uniqueness: true
end
