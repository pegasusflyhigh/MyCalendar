# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Routes for Google authentication
  root 'sessions#new'

  get 'auth/:provider/callback', to: 'sessions#google_auth'
  get 'auth/failure', to: redirect('/')

  get 'login', to: redirect('/auth/google_oauth2')
  get 'logout', to: 'sessions#logout'
end
