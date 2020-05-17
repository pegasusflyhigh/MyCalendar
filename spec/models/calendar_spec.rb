# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Calendar, type: :model do
  context 'associations' do
    it { should have_many(:events).dependent(:destroy) }
    it { should belong_to(:user) }
  end

  context 'validations' do
    it { should validate_presence_of(:g_id) }
    it { should validate_uniqueness_of(:g_id).scoped_to(:user_id) }
  end
end
