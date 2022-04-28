class Tag < ApplicationRecord
  validates :label, presence: true, uniqueness: true
  has_and_belongs_to_many :event
end
