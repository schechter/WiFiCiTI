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
  #geocoded_by   will be used for adding hotspots later

  has_many :ratings
  has_many :users, through: :ratings

  geocoded_by :location
  after_validation :geocode

  validates_presence_of :fee, :latitude, :longitude, :name
  validates :latitude, numericality: true, allow_blank: false
  validates :longitude, numericality: true, allow_blank: false

  def self.find_hs(user)
    Hotspot.near([user.latitude,
                  user.longitude], 0.2, order: :distance)
  end

  def self.get_addresses_from_hs_array(hs_array) #takes an array of hotspots and returns and array of arrays of lat&long
    addresses = []
    hs_array.each do |hs|
      addresses << [hs.latitude, hs.longitude]
    end
    addresses  #returns any [array of [arrays containing lat and long BigDecimal numbers]]
  end

  def self.address_to_marker_generator(addresses) # takes in an array of arrays of lat and long.
    markers = ''
    addresses.each do |lat, long|
      markers += "|" + lat.to_s + "," + long.to_s
    end
    markers  #returns a string of locations, each one starting with a pipe (|) latitude (,) longitude  -no need to be longer than 6 digits after decimal
  end

  #commented out this version of the method.  If we want to be able to change the size or icon this one will be more useful.  otherwise use smaller version below
  # def hot_spots_map(markers, map_size = '480x480', map_icon = 'http://goo.gl/3KRsr')
  #   url = ''
  #   print "map size +++++++++++++"
  #   p map_size
  #   begining_url_section = 'http://maps.googleapis.com/maps/api/staticmap?'  #map type that will center on given markers
  #   map_size_url_section = "size=#{map_size}&"  #duh
  #   map_icon_url_section = "markers=icon:#{map_icon}"  #links to minified url of goodle drive icon
  #   end_url_section = '&sensor=false'
  #   url += begining_url_section + map_size_url_section + map_icon_url_section + markers + end_url_section
  #   url
  # end

  def self.hot_spots_map(markers)
    url = ''
    begining_url_section = 'http://maps.googleapis.com/maps/api/staticmap?size=480x480&markers=icon:http://goo.gl/3KRsr'
    end_url_section = '&sensor=false'
    url = begining_url_section + markers + end_url_section
  end

  def self.hs_near_user
    hotspots = Hotspot.near(User.all[1...6].first.location,0.185)  #just using dumby user for now.  need to pass in the user here
    @map_url = Hotspot.hot_spots_map(Hotspot.address_to_marker_generator(Hotspot.get_addresses_from_hs_array(hotspots)))
  end



end
