class Spree::NotificationRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :country

  scope :acvtives, -> { where(active: true) }
  scope :in_acvtives, -> { where(active: false) }
  scope :fulfilled, -> { where(fulfilled: true) }
  scope :not_fulfilled, -> { where(fulfilled: false) }
  scope :in_progress, -> { acvtives.not_fulfilled }

  with_options presence: true do
    validates :country
    validates :longitude
    validates :latitude
    validates :email, format: { with: Devise.email_regexp, allow_blank: true }
  end

  with_options inclusion: { in: [true, false] } do
    validates :active
    validates :fulfilled
  end

  before_validation :assign_country

  attr_accessor :string_country

  def fulfill!
    update fulfilled: true
  end

  private

  def assign_country
    self.country ||= Spree::Country.where(name: string_country).first if string_country
  end
end
