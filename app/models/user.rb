class User < ActiveRecord::Base
  attr_accessible :email, :latitude, :location, :longitude, :name
  
  geocoded_by :location
  after_validation :geocode

  has_many :ratings
  has_many :hotspots, through: :ratings

end
