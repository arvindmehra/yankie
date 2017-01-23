Spree::Variant.class_eval do
  has_many :variant_locations, dependent: :destroy, before_add: :set_nest

  has_one :service_provider, through: :product

  accepts_nested_attributes_for :variant_locations, allow_destroy: true, reject_if: lambda { |vl| vl[:kind].blank? }

  # Skip
  # validates :option_values, presence: true, unless: :is_master?
  _validators.reject!{ |key, value| key == :option_values }
  _validate_callbacks.each do |callback|
    callback.raw_filter.attributes.reject! { |key| key == :option_values } if callback.raw_filter.respond_to?(:attributes)
  end

  private

  def set_nest(child)
    child.variant ||= self
  end
end
