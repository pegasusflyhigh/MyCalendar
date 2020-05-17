# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it { should have_many(:calendars).dependent(:destroy) }
    it { should have_many(:events).through(:calendars) }
  end

  context 'validations' do
    it { should validate_uniqueness_of(:email) }
  end
end
