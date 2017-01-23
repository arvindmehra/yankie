class Spree::ContactRequest < ActiveRecord::Base
  belongs_to :user

  with_options presence: true do
    validates :subject
    validates :message
    validates :name
    validates :email, format: { with: Devise.email_regexp, allow_blank: true }
  end

  scope :ordered, -> { order(id: :desc) }

  state_machine :state, initial: :pending do
  end
end
