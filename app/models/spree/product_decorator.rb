Spree::Product.class_eval do
  has_many :variant_locations, through: :variants
  has_many :product_time_ranges, dependent: :destroy, before_add: :set_nest
  belongs_to :service_provider, class_name: 'Spree::User', foreign_key: :service_provider_id

  with_options presence: true do
    validates :service_provider
    validates :duration
  end

  validate :possible_service_provider

  scope :with_taxons, -> { joins(:taxons) }
  scope :b2b, -> { with_taxons.where(spree_taxons: { name: 'B2B' }) }
  scope :b2c, -> { with_taxons.where(spree_taxons: { name: 'B2C' }) }
  scope :b2b_or_b2c, -> { with_taxons.where("spree_taxons.name = 'B2C' OR spree_taxons.name = 'B2B'") }

  accepts_nested_attributes_for :product_time_ranges, allow_destroy: true, reject_if: lambda { |ptr| ptr[:week_day].blank? && ptr[:specific_date].blank? }

  def self.corresponding_location(latitude, longitude, country)
    where(id: Spree::Product.unscoped.all.includes(:variant_locations).to_a.select do |p|
      p.variant_locations.any? { |v_l| v_l.enough_close?(latitude, longitude, country) }
    end.map(&:id))
  end

  def main_corresponded_location_variant(latitude, longitude, country)
    # Get the most expensive corresponded location variant
    variants.to_a.select do |variant|
      variant.variant_locations.any? { |v_l| v_l.enough_close?(latitude, longitude, country) }
    end.max { |v1, v2| v1.cost_price <=> v2.cost_price }
  end

  def self.first_four_for_by_criteria(criteria, _latitude = nil, _longitude = nil, _country = nil)
    send(criteria).first 4
  end

  def self.yoyakkas_top_pick
    b2c
  end

  def self.more_yoyakka_picks
    b2b
  end

  def self.more_options
    b2b_or_b2c
  end

  def possible_service_provider
    return if service_provider.blank? || service_provider.can_be_provider?

    errors.add(:service_provider, 'You cannot be a service provider')
  end

  def duration_in_mins
    duration.try(:min).to_i + duration.try(:hour).to_i * 60
  end

  def available_for?(date, time = nil)
    product_time_ranges.any? { |product_time_range| product_time_range.available_for?(date, time) }
  end

  # Stub to avoid creating a new one for variants
  def empty_option_values?
    false
  end

  private

  def set_nest(child)
    child.product ||= self
  end
end
