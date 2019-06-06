class Voter < ApplicationRecord
  has_many :submission_votes, dependent: :destroy
  has_many :submissions, through: :submission_votes

  validates :email_address, presence: true, email: true
end
