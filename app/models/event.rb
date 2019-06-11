class Event < ApplicationRecord
  belongs_to :user

  has_many :submissions
  has_many :submission_votes, through: :submissions
  has_many :voters, -> { distinct }, through: :submission_votes

  has_one_attached :logo

  validates :name, presence: true
  validates :cfp_open_until, presence: true
  validates :date_of_event, presence: true, future: true
  validates :available_slots, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 50 }

  before_create :generate_voting_token

  scope :by_upcoming, -> { order('cfp_open_until') }

  def cfp_open?
    cfp_open_until.future?
  end

  private

  def generate_voting_token
    self.voting_token = SecureRandom.uuid
  end
end
