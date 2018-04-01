class Addresslanlng < ApplicationRecord
  validates_presence_of :address

  geocoded_by :address

  after_validation :geocode
  
end
