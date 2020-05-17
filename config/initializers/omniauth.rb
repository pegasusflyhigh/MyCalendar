# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Figaro.env.google_client_id, Figaro.env.google_client_secret,
           { scope: 'userinfo.email, calendar', skip_jwt: true }
  # prompt: "consent", access_type: "offline"
end
