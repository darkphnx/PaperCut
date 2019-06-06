class SubmissionVote < ApplicationRecord
  belongs_to :submission
  belongs_to :voter

  validates :weight, presence: true

  scope :with_comments, -> { where("comment IS NOT NULL") }
end
