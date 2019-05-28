class SubmissionVote < ApplicationRecord
  belongs_to :submission
  belongs_to :voter
end
