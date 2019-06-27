require 'rails_helper'

RSpec.describe Submission, type: :model do
  describe 'associations' do
    it { should belong_to(:event) }
    it { should have_many(:submission_votes) }
    it { should have_many(:voters) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:email_address) }
    it { should validate_presence_of(:biography) }
    it { should validate_presence_of(:abstract) }
    it { should validate_inclusion_of(:shortlist_status).in_array(described_class::SHORTLIST_STATUSES) }
  end

  describe '.by_random' do
    it 'returns submissions in a pseudorandom order' do
      submissions = create_list(:submission, 3)

      random_seed = 226
      randomised_submissions = described_class.by_random(random_seed).to_a

      # Results must be in a different order but containing all of the same elements
      expect(randomised_submissions).to_not eq(submissions)
      expect(randomised_submissions.length).to eq(submissions.length)
      expect(randomised_submissions).to include(*submissions)
    end
  end

  describe '.shortlisted' do
    it 'returns only events with a shortlist set to true' do
      shortlisted = create_list(:submission, 2, shortlisted: true)
      _not_shortlisted = create(:submission, shortlisted: false)

      by_shortlisted = described_class.shortlisted.to_a

      expect(by_shortlisted).to eq(shortlisted)
    end
  end

  describe '.not_shortlisted' do
    it 'returns only events with a shortlist set to false' do
      not_shortlisted = create_list(:submission, 2, shortlisted: false)
      _shortlisted = create(:submission, shortlisted: true)

      by_not_shortlisted = described_class.not_shortlisted.to_a

      expect(by_not_shortlisted).to eq(not_shortlisted)
    end
  end

  describe '.by_popularity' do
    it 'returns submissions ordered by their average rating' do
      low_rated = create(:submission, :low_rated)
      medium_rated = create(:submission, :medium_rated)
      high_rated = create(:submission, :high_rated)

      by_popularity = described_class.by_popularity.to_a

      expect(by_popularity).to eq([high_rated, medium_rated, low_rated])
    end
  end

  describe '.by_shortlist_status' do
    it 'returns submissions prioritised by shortlist_status (accepted, invited, backup, unavailable, NULL)' do
      no_status = create(:submission, shortlist_status: nil)
      unavailable = create(:submission, shortlist_status: 'unavailable')
      accepted = create(:submission, shortlist_status: 'accepted')
      invited = create(:submission, shortlist_status: 'invited')
      backup = create(:submission, shortlist_status: 'backup')

      by_shortist_status = described_class.by_shortlist_status.to_a

      expect(by_shortist_status).to eq([accepted, invited, backup, unavailable, no_status])
    end
  end

  describe '.from_csv' do
    pending 'A bit of throwaway code, will be replaced by submission API'
  end

  describe '#votes' do
    it 'totals up all of the weights from its votes' do
      submission = create(:submission)
      create(:submission_vote, submission: submission, weight: 3)
      create(:submission_vote, submission: submission, weight: 4)

      votes = submission.votes

      expect(votes).to eq(7)
    end
  end

  describe '#average_rating' do
    it 'calculates an average of vote weights' do
      submission = create(:submission)
      create(:submission_vote, submission: submission, weight: 3)
      create(:submission_vote, submission: submission, weight: 4)

      average = submission.average_rating

      expect(average).to eq(3.5)
    end
  end

  describe 'shortlist!' do
    it 'sets shortlisted to true' do
      submission = create(:submission)

      submission.shortlist!

      expect(submission.shortlisted).to be(true)
    end
  end

  describe 'unshortlist!' do
    it 'sets shortlisted to false' do
      submission = create(:submission)

      submission.unshortlist!

      expect(submission.shortlisted).to be(false)
    end
  end
end
