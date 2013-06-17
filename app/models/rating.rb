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

  def self.calculate_avg_rating(id)
    hs = Hotspot.find(id)
    ratings = hs.ratings
    unless ratings == []
      total_avg_rating = []
      ratings.each do |rating|
        average_rating = [rating.speed, rating.reliability, rating.accessibility, rating.power, rating.noise_level].avg
        total_avg_rating << average_rating
      end
      total_avg_rating.avg
    else
      total_avg_rating = 0
    end
  end

  def self.average_ratings(hotspots)
    hotspots_hash = {}
    hotspots.each do |hotspot|
      hotspots_hash[hotspot.id] = calculate_avg_rating(hotspot.id)
    end
    hotspots_hash
  end

  class Array  #new method for array, average to 2 decimals ##DELETE ME IF NOT USED
    def avg
      blank? and 0.0 or (sum.to_f/size).round(2)
    end
  end
end
