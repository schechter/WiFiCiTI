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

require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
