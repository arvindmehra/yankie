# == Schema Information
#
# Table name: spree_user_feedbacks
#
#  id                  :integer          not null, primary key
#  text                :string           default(""), not null
#  stars               :integer          default(1), not null
#  service_provider_id :integer          not null
#  user_id             :integer          not null
#  state               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class Spree::UserFeedbackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
