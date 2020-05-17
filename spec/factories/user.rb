# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name  { 'Doe' }
    sequence(:email, 1000) { |n| "person#{n}@example.com" }
  end
end
