class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :fullname, presence: true, length: { maximum: 30 }
  validates :username, presence: true, length: { maximum: 12 }, uniqueness: true
  validates :date_of_birth, presence: true
  validate :registrable?
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true
  #validates :image, presence: true

  enum :role, {admin: 0, member: 1, banned: 2}, default: :member
  
  has_many :inscriptions 
  has_many :events, through: :inscriptions , dependent: :destroy
  has_one_attached :image,  dependent: :destroy
  has_many :active_friendship, class_name: "Friendship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_friendship, class_name: "Friendship", foreign_key: "followed_id", dependent: :destroy
  has_many :followed_user, through: :active_friendship, source: :followed_user
  has_many :follower_user, through: :passive_friendship, source: :follower_user

  def registrable?
    return errors.add( :date_of_birth, 'must be at least 9 years old.' ) unless self.date_of_birth
    errors.add( :date_of_birth, 'You should be over 9 years old.' ) if age < 9 
    
  end

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