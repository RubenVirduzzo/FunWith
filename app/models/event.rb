class Event < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  validates :date_event, presence: true
  validates :duration_time, presence: true
  validates :place, presence: true
  validates :min_age, presence: true
end