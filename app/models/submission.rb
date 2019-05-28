class Submission < ApplicationRecord
  belongs_to :event

  has_many :submission_votes, dependent: :destroy
  has_many :voters, through: :submission_votes
end
