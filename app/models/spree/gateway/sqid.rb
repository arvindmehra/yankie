class Spree::Gateway::SQID < Spree::Gateway
  attr_accessor :server, :test_mode

  preference :server,:string, default: 'test'
  preference :test_mode, :boolean, default: true

  def payment_source_class
    Spree::CreditCard
  end

  def method_type
    'sqid'
  end

  def auto_capture?
    true
  end

  def payment_profiles_supported?
    false
  end

  def purchase(amount, transaction_details, options = {})
    provider = credit_card_provider(transaction_details, options)
    provider.purchase(*options_for_purchase_or_auth(amount, transaction_details, options))
  end

  def provider_class
    ::SQID::Purchase
  end

  private

  def options_for_purchase_or_auth(money, creditcard, gateway_options)
    options = {}
    order = Spree::Order.find_by(number: gateway_options[:order_id].split('-').first)
    address = order.bill_address

    options[:description] = "Yoyakka Order ID: #{gateway_options[:order_id]}"
    options[:reference_id] = gateway_options[:order_id]
    options[:full_name] = address.full_name
    options[:address1] = address.address1
    options[:city] = address.city
    options[:suburb] = address.city
    options[:country] = address.country.iso3
    options[:state] = address.state.name
    options[:zipcode] = address.zipcode
    options[:card_number] = creditcard.number
    options[:card_expiry] = creditcard.to_active_merchant.expiry_date.expiration.strftime("%m%y")
    options[:card_cvv] = creditcard.verification_value
    options[:card_name] = creditcard.name
    options[:email] = gateway_options[:email]
    options[:ip] = gateway_options[:ip]

    # Add recepient's creds
    options[:creds] = {
      api_key: order.service_provider.api_key,
      api_merchant_code: order.service_provider.api_merchant_code,
      api_passphrase: order.service_provider.api_passphrase
    }

    return money / 100.to_d, nil, options
  end

  def credit_card_provider(credit_card, options = {})
    @provider ||= provider_class.new
  end
end
