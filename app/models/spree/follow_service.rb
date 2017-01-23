class Spree::FollowService < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  with_options presence: true do
    validates :user
    validates :product
  end
end
