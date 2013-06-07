class Hotspot < ActiveRecord::Base
  attr_accessible :city, :fee, :latitude, :longitude, :name, :phone, :street, :url, :zip

  def self.named
  	Hotspot.where(['name <> ?', :street]).order('name ASC')
  end
end
