class Tag < ApplicationRecord
  validates :label, presence: true, uniqueness: true
  has_one :event
end
