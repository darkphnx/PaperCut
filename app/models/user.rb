class User < ApplicationRecord
  has_many :sessions, class_name: 'Authie::Session', as: :user, dependent: :destroy
end
