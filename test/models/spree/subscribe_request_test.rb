# == Schema Information
#
# Table name: spree_subscribe_requests
#
#  id                      :integer          not null, primary key
#  salutation              :integer
#  firstname               :string
#  initial                 :string(1)
#  surname                 :string
#  email                   :string
#  birth_date              :date
#  mobile_number           :string
#  phone_number            :string
#  fax_number              :string
#  gender                  :integer
#  secret_question         :integer
#  secret_answer           :string
#  referred_by             :string
#  i_agree                 :boolean
#  have_already_account    :boolean          not null
#  existing_account_number :string
#  address_id              :integer
#  delivery_address_id     :integer
#  service_provider_id     :integer          not null
#  state                   :string
#  approved_at             :datetime
#  rejected_at             :datetime
#  role_user_id            :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  api_key                 :string
#  api_merchant_code       :string
#  api_passphrase          :string
#

require 'test_helper'

class Spree::SubscribeRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
