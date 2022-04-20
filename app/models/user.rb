class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :fullname, presence: true, length: { maximum: 30 }
  validates :username, presence: true
  validates :date_of_birth, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  enum role: [:admin, :member, :banned]

  def age
    ((Time.zone.now - self.date_of_birth.to_time) /  1.year.seconds).floor
  end

  def underage?
    age < 18
  end
end

