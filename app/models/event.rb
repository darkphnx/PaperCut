class Event < ApplicationRecord
  belongs_to :user

  has_many :submissions
  has_one_attached :logo

  validates :name, presence: true
  validates :cfp_open_until, presence: true, future: true
  validates :date_of_event, presence: true, future: true

  scope :by_upcoming, -> { order('cfp_open_until') }

  def cfp_open?
    cfp_open_until.future?
  end
end
