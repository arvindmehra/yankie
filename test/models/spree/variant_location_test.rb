# == Schema Information
#
# Table name: spree_variant_locations
#
#  id         :integer          not null, primary key
#  variant_id :integer          not null
#  country_id :integer
#  latitude   :float            default(0.0), not null
#  longitude  :float            default(0.0), not null
#  radius_km  :float            default(0.0), not null
#  address    :string           default(""), not null
#  kind       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class Spree::VariantLocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
