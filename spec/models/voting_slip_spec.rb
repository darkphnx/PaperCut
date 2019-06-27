require 'rails_helper'

RSpec.describe VotingSlip, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email_address) }
    it { should validate_presence_of(:submissions) }

    it 'validates the uniqueness of the email address' do
      event = create(:event)
      submission = create(:submission, event: event)
      voter = create(:voter, email_address: "doublevoter@example.org")
      submission_vote = create(:submission_vote, submission: submission, voter: voter)

      voting_slip = VotingSlip.new(event: event, email_address: voter.email_address)
      voting_slip.valid?

      expect(voting_slip.errors.full_messages).to include("Email address is already associated with a voting slip " \
        "for this event")
    end
  end

  describe '#save' do
    it 'creates a new Voter with the email_address' do
      event = create(:event)
      submission = create(:submission, event: event)

      voting_slip = VotingSlip.new(event: event, email_address: "emcgregor@example.org", submissions: {
        submission.id => { vote_weight: 5 }
      })
      voting_slip.save

      expect(submission.voters.first.email_address).to eq("emcgregor@example.org")
    end

    it 'creates a set of SubmissionVotes from the submissions' do
      event = create(:event)
      submission_1 = create(:submission, event: event)
      submission_2 = create(:submission, event: event)

      voting_slip = VotingSlip.new(event: event, email_address: "emcgregor@example.org", submissions: {
        submission_1.id => { vote_weight: 5 },
        submission_2.id => { vote_weight: 2 }
      })
      voting_slip.save

      expect(submission_1.submission_votes.count).to eq(1)
      expect(submission_2.submission_votes.count).to eq(1)
    end

    it 'sets an error if validation fails creating a SubmissionVote' do
      event = create(:event)
      submission = create(:submission, event: event)

      voting_slip = VotingSlip.new(event: event, email_address: "emcgregor@example.org", submissions: {
        submission.id => { vote_weight: -1 }
      })
      voting_slip.save

      expect(voting_slip.errors.full_messages).to include("Sorry, couldn't save your results right now.")
    end
  end
end
