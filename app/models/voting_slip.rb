class VotingSlip
  include ActiveModel::Model

  attr_accessor :event, :email_address, :ratings

  validates :email_address, presence: true
  validates :ratings, length: { minimum: 1 }

  # Creates a new voter and attributes votes to them
  def save
    return false unless valid?

    Voter.transaction do
      voter = Voter.create!(email_address: email_address)

      ratings.each do |submission_id, vote_weight|
        submission = event.submissions.find(submission_id)

        voter.submission_votes.create!(submission: submission, weight: vote_weight)
      end
    end
  rescue ActiveRecord::RecordInvalid
    errors.add(:base, "Sorry, couldn't save your results right now.")
    false
  end
end
