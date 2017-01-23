class Spree::ServiceProviderRating < ActiveRecord::Base
  belongs_to :service_provider, class_name: 'Spree::User', foreign_key: :service_provider_id

  has_many :service_provider_feedbacks,
           class_name: 'Spree::UserFeedback', through: :service_provider, dependent: :destroy

  with_options presence: true do
    validates :value, inclusion: { in: [0, 1, 2, 3, 4, 5], allow_blank: true }
    validates :service_provider
  end

  scope :have_rating, -> { where.not(value: 0) }
  scope :have_no_rating, -> { where(value: 0) }

  def has_rating?
    value.nonzero?
  end

  def has_no_rating?
    value.zero?
  end

  def recalculate!
    scope = service_provider_feedbacks.approved

    # Set the smallest Integer greater than or equal to the average value of approved users feedbacks stars.
    if scope.count.zero?
      update value: 0
    else
      update value: (scope.sum(:stars).to_f / scope.count).ceil
    end
  end
end
