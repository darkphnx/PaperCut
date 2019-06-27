require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:submissions) }
    it { should have_many(:submission_votes) }
    it { should have_many(:voters) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cfp_open_until) }
    it { should validate_presence_of(:date_of_event) }
    it { should validate_presence_of(:available_slots) }
    it { should validate_numericality_of(:available_slots).is_greater_than(0).is_less_than_or_equal_to(50) }
  end

  describe 'callbacks' do
    describe 'before_validation' do
      it 'generates a UUID for #voting_token' do
        event = build(:event)
        event.valid?
        expect(event.voting_token).to_not be_blank
      end
    end
  end

  describe '.by_upcoming' do
    it 'orders events by upcoming date (descending)' do
      events = [
        create(:event, cfp_open_until: Time.now.utc + 1.month),
        create(:event, cfp_open_until: Time.now.utc + 1.hour),
        create(:event, cfp_open_until: Time.now.utc + 1.week)
      ]

      sorted_events = events.sort_by(&:cfp_open_until)
      expect(described_class.by_upcoming.to_a).to eq(sorted_events)
    end
  end

  describe '#cfp_open?' do
    it 'is true when CFP date is in future' do
      event = build(:event, cfp_open_until: Time.now.utc + 1.hour)

      expect(event.cfp_open?).to be(true)
    end

    it 'is false when CFP date is in past' do
      event = build(:event, cfp_open_until: Time.now.utc - 1.hour)

      expect(event.cfp_open?).to be(false)
    end
  end
end
