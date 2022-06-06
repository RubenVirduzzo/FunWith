class Tag < ApplicationRecord
  validates :label, presence: true, uniqueness: true
  validates :description, presence: true
  validates :image, presence: true
  
  has_and_belongs_to_many :events
  has_one_attached :image
end
