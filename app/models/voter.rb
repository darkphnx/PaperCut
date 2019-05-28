class Voter < ApplicationRecord
  has_many :submission_votes, dependent: :destroy
  has_many :submissions, through: :submission_votes
end
