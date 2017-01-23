module Spree
  class VariantLocation < Spree::Base
    belongs_to :variant
    has_one :product, through: :variant
    belongs_to :country

    enum kind: {
      provided_online: 0,
      business_location: 1,
      customer_location: 2,
      provided_nationally: 3,
      provided_globally: 4
    }

    with_options presence: true do
      validates :kind
      validates :variant
      validates :country, if: :must_have_country?
      validates :radius_km, numericality: { greater_than: 0, allow_blank: true }, if: :must_have_address?
      validates :address, if: :must_have_address?
    end

    geocoded_by :address
    after_validation :geocode # auto-fetch coordinates

    after_save :handle_changes

    def must_have_address?
      business_location? || customer_location?
    end

    def must_have_country?
      must_have_address? || provided_nationally?
    end

    def enough_close?(user_latitude, user_longitude, user_country)
      provided_globally? || provided_online? || (provided_nationally? &&
        user_country == country.try(:name)) || distance_from([user_latitude, user_longitude], :km) < radius_km
    end

    private

    def handle_changes
      ::HandleNewVariantLocation.perform_async(id)
    end
  end
end
