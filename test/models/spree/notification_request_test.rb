# == Schema Information
#
# Table name: spree_notification_requests
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  latitude   :float            not null
#  longitude  :float            not null
#  country_id :integer          not null
#  user_id    :integer
#  active     :boolean          default(TRUE), not null
#  fulfilled  :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class Spree::NotificationRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
