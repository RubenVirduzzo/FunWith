class Location < ApplicationRecord
  attr_accessor :address, :latitude, :longitude
  geocoded_by :full_street_address 
  after_validation :geocode
  

  # def address
  #   [:street, :city, :state, :country].compact.join(', ')
  # end
end
