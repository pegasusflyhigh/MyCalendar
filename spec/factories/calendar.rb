# frozen_string_literal: true

FactoryBot.define do
  factory :calendar do
    g_id  { SecureRandom.uuid }
    association :user
  end
end
