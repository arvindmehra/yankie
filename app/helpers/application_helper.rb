module ApplicationHelper
  def current_variant_price(variant)
    Spree::Money.new(variant.price, { currency: current_currency }).to_html if variant.present?
  end

  def current_service_provider_phone(product)
      return product.service_provider.ship_address.phone if product.service_provider.ship_address.phone.present?
      return product.service_provider.bill_address.phone if product.service_provider.bill_address.phone.present?
  end

  def current_service_provider_address(product)
    return full_address(product.service_provider.ship_address) if product.service_provider.ship_address.present?
  end

  def active_class?(target_page)
    send(target_page) ? 'active' : ''
  end

  def catalog_page?
    current_page?('/products')
  end

  def my_services_page?
    current_page?('/users/my_services')
  end

  def edit_location_page?
    current_page?('/users/edit_location')
  end

  def current_address
    Geocoder.search("#{cookies['user_latitude']}, #{cookies['user_longitude']}").first.address if cookies['user_latitude'].present? && cookies['user_longitude'].present?
  end

  def get_current_address
    Geocoder.search("#{cookies[:user_latitude]},#{cookies[:user_longitude]}").first
  end

  private
    def full_address (address)
      return (address.address1+", "+address.address2+", "+address.city+" "+address.zipcode+" "+address.city+" "+address.state.name+" "+address.country.name).to_s
    end
end
