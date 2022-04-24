class Tag < ApplicationRecord
  validates :label, presence: true, uniqueness: true
  validates :description, presence: true
  
  has_one :event

end
