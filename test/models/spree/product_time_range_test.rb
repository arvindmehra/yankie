# == Schema Information
#
# Table name: spree_product_time_ranges
#
#  id            :integer          not null, primary key
#  product_id    :integer          not null
#  week_day      :integer
#  specific_date :date
#  time_from     :time
#  time_to       :time
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class Spree::ProductTimeRangeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
