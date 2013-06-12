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

end
