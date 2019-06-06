class VotingSlip
  include ActiveModel::Model

  attr_accessor :event, :email_address, :submissions

  validates :email_address, presence: true
  validates :submissions, presence: true

  # Creates a new voter and attributes votes to them
  def save
    return false unless valid?

    Voter.transaction do
      voter = Voter.create!(email_address: email_address)

      submissions.each do |submission_id, rating|
        submission = event.submissions.find(submission_id)

        submission.submission_votes.create!(voter: voter, weight: rating[:vote_weight], comment: rating[:comment])
      end
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound
    errors.add(:base, "Sorry, couldn't save your results right now.")
    false
  end
end
