module Spree
  class ProductTimeRange < Spree::Base
    belongs_to :product

    delegate :duration, to: :product

    enum week_day: {
      sunday: 0,
      monday: 1,
      tuesday: 2,
      wednesday: 3,
      thursday: 4,
      friday: 5,
      saturday: 6
    }

    with_options presence: true do
      validates :product
      validates :week_day, if: 'specific_date.blank?'
      validates :specific_date, if: 'week_day.blank?'
      validates :time_from
      validates :time_to
    end

    validates_time :time_from, before: :time_to

    with_options absence: true do
      validates :week_day, if: 'specific_date.present?'
      validates :specific_date, if: 'week_day.present?'
    end

    scope :by_date, -> (date) {
      where('week_day = ? OR specific_date = ?', date.wday, date)
    }

    # Return an array
    def self.available_time_for(date)
      times = by_date(date).to_time_options
      # Reject engaged times
      engaged_times = Spree::LineItem
                      .joins(order: :products)
                      .where(spree_products: { id: all.first.product.id })
                      .where(completion_date: date.beginning_of_day..date.end_of_day)
                      .pluck(:completion_date)
                      .map { |t| t.utc.strftime('%H:%M') }

      times.reject { |time| engaged_times.include?(time.utc.strftime('%H:%M')) }
    end

    # Return an array
    def self.to_time_options
      all.to_a.map do |product_time_range|
        (product_time_range.time_from.to_i..product_time_range.time_to.to_i).step(
          product_time_range.product.duration_in_mins * 60
        ).map { |time| Time.at time }
      end.flatten.sort
    end

    def wday
      self[:week_day]
    end

    def available_for?(date, time = nil)
      (date.wday == wday || specific_date == date) && (time.nil? || (time_from..time_to).cover?(time))
    end
  end
end
