class Event < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  validates :date_event, presence: true
  validates :duration_time, presence: true
  validates :place, presence: true
  validates :min_age, presence: true

  belongs_to :organizer, class_name: "User",
                      foreign_key: "organizer_id"


  
  has_many :users, through: :inscriptions
  has_and_belongs_to_many :tag
end