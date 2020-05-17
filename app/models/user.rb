# frozen_string_literal: true

class User < ApplicationRecord
  has_many :calendars, dependent: :destroy
  has_many :events, through: :calendars

  validates :email, uniqueness: true

  def self.from_omniauth(auth_response)
    user = find_or_initialize_by(email: auth_response.info.email)
    user.update_credentials(auth_response.dig('credentials')) && user.update_info(auth_response)
    user
  end

  def google_token_expired?
    google_token_expires_at <= Time.now.to_i
  end

  def refresh_google_token
    response = fetch_google_token
    return if response.blank?

    credentials = JSON.parse(response.body)
    return unless credentials.dig('access_token')

    update_credentials(credentials) && google_token
  end

  def fetch_google_token
    response = HTTParty.post('https://oauth2.googleapis.com/token', body: {
                               grant_type: 'refresh_token',
                               refresh_token: google_refresh_token,
                               client_id: Figaro.env.google_client_id,
                               client_secret: Figaro.env.google_client_secret
                             })
    return response if response.dig('error').blank?

    Rails.logger.error("~~~~~~~~~~~~~Error = #{response.dig('error')}~~~~~~~~~~~~")
    false
  end

  def update_credentials(credentials)
    self.google_token = credentials.dig('token') || credentials.dig('access_token')
    expires_at = credentials.dig('expires_at') || Time.now.to_i + credentials.dig('expires_in').to_i
    self.google_token_expires_at = expires_at if expires_at.present?
    refresh_token = credentials.dig('refresh_token')
    self.google_refresh_token = refresh_token if refresh_token.present?
    save!
  end

  def update_info(auth_response)
    self.name = auth_response.info.name
    self.image_url = auth_response.info.image
    self.token_provider = auth_response.provider
    save!
  end
end
