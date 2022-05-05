class Tag < ApplicationRecord
  validates :label, presence: true, uniqueness: true
  validates :description, presence: true
  has_and_belongs_to_many :event
end
