# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  latitude        :float
#  longitude       :float
#  location        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :latitude, :location, :longitude, :name, :password
  
  has_secure_password
  


  has_many :ratings
  has_many :hotspots, through: :ratings

end
