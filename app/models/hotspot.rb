class Hotspot < ActiveRecord::Base
  attr_accessible :city, :fee, :latitude, :longitude, :name, :phone, :street, :url, :zip
  #geocoded_by   will be used for adding hotspots later

  has_many :ratings
  has_many :users, through: :ratings

	geocoded_by :location
	after_validation :geocode

  validates_presence_of :fee, :latitude, :longitude, :name
  validates :latitude, numericality: true, allow_blank: false
  validates :longitude, numericality: true, allow_blank: false


end
