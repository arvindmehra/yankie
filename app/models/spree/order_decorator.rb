Spree::Order.class_eval do

  def self.own_orders(service_provider_id)
    joins(:products).where(spree_products: { service_provider_id: service_provider_id })
  end

  alias_method :old_finalize!, :finalize!

  def payment_required?
    true
  end

  def confirmation_required?
    false
  end

  def build_default_ship_address
    ship_address||Spree::Address.build_default
  end

  def service_provider
    line_items.first.product.service_provider
  end

  remove_checkout_step :delivery

  # Ovveriden
  def finalize!
    result = old_finalize!

    line_items.each(&:pend)

    result
  end
end
