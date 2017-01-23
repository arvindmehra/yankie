Spree::LineItem.class_eval do
  with_options presence: true do
    validates :details
    validates :completion_date
  end

  validates :quantity, inclusion: { in: [0, 1], allow_blank: true }

  validates_datetime :completion_date, on_or_after: :today, on: :create

  validate :available_time, if: 'completion_date.present?', on: :create
  validate :must_be_pro_service_provider

  validate :ensure_product_only_from_one_provider

  state_machine initial: :checkout do
    state :checkout
    state :pending
    state :approved
    state :completed
    state :rejected

    event :pend do
      transition from: [:checkout], to: :pending
    end

    event :complete do
      transition from: [:pending, :approved], to: :completed
    end

    event :reject do
      transition from: [:approved, :pending, :completed], to: :rejected
    end

    event :approve do
      transition from: [:pending], to: :approved
    end

    after_transition any => :rejected do |line_item, _transition|
      # Make a refund
      Spree::Refund.create(
        amount: line_item.price,
        payment: line_item.order.payments.completed.first,
        reason: Spree::RefundReason.first
      )
    end
  end

  private

  def ensure_product_only_from_one_provider
    return if order.variants.all? { |v| v.service_provider == variant.service_provider }

    errors.add(:base, 'You can add services only from one service provider at the same time.')
  end

  def available_time
    ok = product
         .product_time_ranges
         .available_time_for(completion_date)
         .map { |t| t.utc.strftime('%H:%M') }
         .include?(completion_date.utc.strftime('%H:%M'))

    errors.add(:completion_date, 'is incorrect') unless ok
  end

  def must_be_pro_service_provider
    unless variant.try(:service_provider).try(:pro_service_provider?)
      errors.add(:variant, 'is incorrect, because it must be from a pro service provider')
    end
  end
end
