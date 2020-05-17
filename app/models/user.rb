# frozen_string_literal: true

class User < ApplicationRecord
  has_many :calendars, dependent: :destroy
  has_many :events, through: :calendars

  validates :email, uniqueness: true

  def self.from_omniauth(auth_response)
    user = find_or_initialize_by(email: auth_response.info.email)
    user.save
  end
end
