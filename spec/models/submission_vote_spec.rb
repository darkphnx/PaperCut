require 'rails_helper'

RSpec.describe SubmissionVote, type: :model do
  describe 'associations' do
    it { should belong_to(:submission) }
    it { should belong_to(:voter) }
  end

  describe 'validations' do
    it { should validate_presence_of(:weight) }
    it { should validate_numericality_of(:weight).is_greater_than(0).is_less_than_or_equal_to(5) }
  end

  describe '.with_comments' do
    it 'returns only SubmissionVotes with comments' do
      commenty = create_list(:submission_vote, 2, comment: "Looks gnarly")
      create(:submission_vote)

      with_comments = described_class.with_comments.to_a

      expect(with_comments).to eq(commenty)
    end
  end
end
