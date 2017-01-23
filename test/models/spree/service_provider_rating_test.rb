# == Schema Information
#
# Table name: spree_service_provider_ratings
#
#  id                  :integer          not null, primary key
#  service_provider_id :integer          not null
#  value               :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class Spree::ServiceProviderRatingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
