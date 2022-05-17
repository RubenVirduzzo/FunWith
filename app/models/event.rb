class Event < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  validates :date_event, presence: true
  validates :duration_time, presence: true
  validates :place, presence: true
  validates :min_age, presence: true, numericality: { only_integer: true }

  belongs_to :organizer, class_name: "User",
                      foreign_key: "organizer_id"


  has_many :inscriptions, dependent: :destroy
  has_many :users, through: :inscriptions
  has_and_belongs_to_many :tags

  scope :by_tag, ->(tag_id) { joins(:tags).where("tags.id"=> tag_id) }
  scope :by_place, ->(place) { where( place: place )}

  def self.available_for(user)
    Event.where.not(organizer_id: user.id) - user.inscriptions.map(&:event) - Event.all.select{|event| event.completed?}
  end

  def places_left
    max_number_of_joiners.to_i - inscriptions.count
  end

  def completed?
    places_left == 0
  end
end