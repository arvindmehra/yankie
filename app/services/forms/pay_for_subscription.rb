class Forms::PayForSubscription < ActiveType::Record[::Spree::User]
  attribute :credit_card_id, :integer

  belongs_to :credit_card, class_name: 'Spree::CreditCard'

  with_options presence: true do
    # use bill_address instead
    validates :ship_address
    validates :credit_card
    validates :amount, numericality: { greater_than: 0.0, allow_blank: true }
  end

  def assign_nested_attributes(params)
    build_ship_address(params[:ship_address_attributes])
    build_credit_card(params[:credit_card])
  end

  def call
    return false if invalid?

    create_dependencies
    return false unless pay!

    update_user
    make_roles
    true
  end

  def title
    provider? ? 'a Basic account' : 'a Pro account'
  end

  def description
    "Pay $#{amount.to_f} AUD for #{title}"
  end

  private

  def create_dependencies
    # credit_card. set user id
  end

  def pay!
    response = SQID::Purchase.new.purchase(amount, credit_card_or_reference, options)
    return true if response.success?
    errors.add(:base, response.message)
    false
  end

  def amount
    @amount ||= if provider?
                  ENV['BASIC_ANNUAL_COST'].to_f
                elsif pro_provider?
                  ENV['PRO_ANNUAL_COST'].to_f
                end
  end

  def credit_card_or_reference
    nil
  end

  # rubocop:disable MethodLength
  # rubocop:disable AbcSize
  def options
    @options ||= {
      description:  "Yoyakka Paying for subscription: amount:#{amount}, type: #{title}, user_id:#{id}",
      # Use payment_id instead of self.id
      reference_id: id,
      full_name:    ship_address.full_name,
      address1:     ship_address.address1,
      city:         ship_address.city,
      suburb:       ship_address.city,
      country:      ship_address.country.iso3,
      state:        ship_address.state.name,
      zipcode:      ship_address.zipcode,
      card_number:  credit_card.number,
      card_expiry:  credit_card.to_active_merchant.expiry_date.expiration.strftime('%m%y'.freeze),
      card_cvv:     credit_card.verification_value,
      card_name:    credit_card.name,
      email:        email,
      ip:           current_sign_in_ip
    }
  end

  def update_user
    update_column :paid_amount, amount
  end
end
