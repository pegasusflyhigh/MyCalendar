# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    g_id  { SecureRandom.uuid }
    status { 'confirmed' }
    summary { 'Summary' }
    association :calendar
  end
end
