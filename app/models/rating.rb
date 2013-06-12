# == Schema Information
#
# Table name: ratings
#
#  id            :integer          not null, primary key
#  hotspot_id    :integer
#  user_id       :integer
#  speed         :integer
#  reliability   :integer
#  accessibility :integer
#  power         :integer
#  noise_level   :integer
#  comments      :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Rating < ActiveRecord::Base
  attr_accessible :accessibility, :hotspot_id, :noise_level, :power, :reliability, :speed, :user_id, :comments

  belongs_to :hotspot
  belongs_to :user

  validates_presence_of :accessibility, :hotspot_id, :noise_level, :power, :reliability, :speed
  validates :accessibility, numericality: true, allow_blank: false
  validates :noise_level, numericality: true, allow_blank: false
  validates :power, numericality: true, allow_blank: false
  validates :reliability, numericality: true, allow_blank: false
  validates :speed, numericality: true, allow_blank: false


end
