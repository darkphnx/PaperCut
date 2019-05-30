class User < ApplicationRecord
  has_many :sessions, class_name: 'Authie::Session', as: :user, dependent: :destroy

  def self.authenticate(email_address, password)
    find_by(email_address: email_address).try(:authenticate, password)
  end
end
