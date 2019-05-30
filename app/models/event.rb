class Event < ApplicationRecord
  belongs_to :user

  has_many :submissions

  validates :name, presence: true
  validates :cfp_open_until, presence: true, future: true
end
