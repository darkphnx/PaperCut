class User < ApplicationRecord
  has_secure_password

  has_many :sessions, class_name: 'Authie::Session', as: :user, dependent: :destroy
  has_many :events

  validates :name, presence: true
  validates :email_address, email: true

  def self.authenticate(email_address, password)
    find_by(email_address: email_address).try(:authenticate, password)
  end
end
