# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'associations' do
    it { should belong_to(:calendar) }
  end

  context 'validations' do
    it { should validate_presence_of(:summary) }
    it { should validate_presence_of(:g_id) }
    it { should validate_uniqueness_of(:g_id).scoped_to(:calendar_id) }
  end

  describe 'active' do
    before do
      create_list(:event, 2, status: 'cancelled')
      create_list(:event, 1)
    end

    it 'returns events which are not cancelled' do
      expect(Event.active.count).to eq(1)
    end
  end
end
