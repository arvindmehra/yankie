# == Schema Information
#
# Table name: spree_assets
#
#  id                      :integer          not null, primary key
#  viewable_id             :integer
#  viewable_type           :string
#  attachment_width        :integer
#  attachment_height       :integer
#  attachment_file_size    :integer
#  position                :integer
#  attachment_content_type :string
#  attachment_file_name    :string
#  type                    :string(75)
#  attachment_updated_at   :datetime
#  alt                     :text
#  created_at              :datetime
#  updated_at              :datetime
#

require 'test_helper'

class Spree::DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
