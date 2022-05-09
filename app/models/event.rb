class Event < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  validates :date_event, presence: true
  validates :duration_time, presence: true
  validates :place, presence: true
  validates :min_age, presence: true, numericality: { only_integer: true }

  belongs_to :organizer, class_name: "User",
                      foreign_key: "organizer_id"


  has_many :inscriptions
  has_many :users, through: :inscriptions
  has_and_belongs_to_many :tag

  def self.available_for(user)
    events = Event.where(organizer_id: user.id)
    Event.all - user.inscriptions.map(&:event) - events
  end

  def places_left
    max_number_of_joiners.to_i - inscriptions.count
  end

  def completed?
    places_left == 0
  end
end