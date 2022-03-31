class User < ApplicationRecord
    validates :fullname, presence: true, length: { maximum: 30 }
    validates :username, presence: true
    validates :age, numericality: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
