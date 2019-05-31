class Event < ApplicationRecord
  belongs_to :user

  has_many :submissions
  has_one_attached :logo

  validates :name, presence: true
  validates :cfp_open_until, presence: true, future: true
  validates :date_of_event, presence: true, future: true
end
