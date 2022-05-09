class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :fullname, presence: true, length: { maximum: 30 }
  validates :username, presence: true
  validates :date_of_birth, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  enum :role, {admin: 0, member: 1, banned: 2}, default: :member
  
  has_many :inscriptions
  has_many :events, through: :inscriptions, unique: true

  def age
    (( Time.zone.now - self.date_of_birth ) /  1.year.seconds).floor
  end

  def underage?
    age < 18
  end

  def inscripted?(event)
    inscription_by_event(event).present?
  end

  def inscription_by_event(event)
    inscriptions.by_event(event)&.first
  end

end