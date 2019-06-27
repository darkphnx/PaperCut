class SubmissionVote < ApplicationRecord
  belongs_to :submission
  belongs_to :voter

  validates :weight, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }

  scope :with_comments, -> { where("comment IS NOT NULL") }
end
