# == Schema Information
#
# Table name: hotspots
#
#  id         :integer          not null, primary key
#  latitude   :decimal(, )
#  longitude  :decimal(, )
#  name       :string(255)
#  street     :string(255)
#  city       :string(255)
#  zip        :string(255)
#  phone      :string(255)
#  fee        :string(255)
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Hotspot < ActiveRecord::Base
  attr_accessible :city, :fee, :latitude, :longitude, :name, :phone, :street, :url, :zip
  geocoded_by :street #  will be used for adding hotspots later

  has_many :ratings
  has_many :users, through: :ratings

  #geocoded_by :location
  after_validation :geocode

  validates_presence_of :fee, :latitude, :longitude, :name
  validates :latitude, numericality: true, allow_blank: false
  validates :longitude, numericality: true, allow_blank: false

  def self.find_by_address(user_location)
    Hotspot.near(user_location, 0.35, order: 'distance').all[0..20]

  end

  def self.find_by_ip_address
    #user_location = Geocoder.search(request.remote_ip, :timeout => 7).first.data)
    user_location = Geocoder.search('208.185.23.206', :timeout => 7).first.data
    lat = user_location['latitude'].to_s
    long = user_location['longitude'].to_s
    Hotspot.near([lat,long],0.3, order: 'distance').all[0...20]
  end

  def self.url_gen(hotspots)
    google_map = "http://maps.googleapis.com/maps/api/staticmap?size=680x480&markers=icon:http://goo.gl/3KRsr"
    hotspots.each do |hotspot|
      markers = "|#{hotspot['latitude'].to_f},#{ hotspot['longitude'].to_f}"
      google_map += markers
    end
    google_map += "&maptype=terrain&sensor=false"
  end
end