Spree::User.class_eval do
  WANTED_TO_BECOMES = {
    user: 0,
    provider: 1,
    pro_provider: 2
  }.freeze

  belongs_to :country

  has_one :service_provider_rating, foreign_key: :service_provider_id

  has_one :subscribe_request, foreign_key: :service_provider_id, dependent: :destroy
  has_many :subscribe_requests, foreign_key: :service_provider_id, dependent: :destroy

  has_many :services, class_name: 'Spree::Product', foreign_key: :service_provider_id, dependent: :destroy
  has_many :notification_requests, dependent: :destroy
  has_many :user_feedbacks, dependent: :destroy
  has_many :service_provider_feedbacks,
           class_name: 'Spree::UserFeedback', foreign_key: :service_provider_id, dependent: :destroy
  has_many :follow_services, dependent: :destroy
  has_many :followed_services, through: :follow_services, class_name: 'Spree::Product', source: :product
  has_many :contact_requests, dependent: :destroy

  attr_accessor :address

  # We use service for it
  # after_commit :make_roles, on: :create

  # When signing up for compatibility
  enum wanted_to_become: {
    user: 0,
    provider: 1,
    pro_provider: 2
  }

  geocoded_by :address

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    geo = results.first
    obj.country = Spree::Country.where(name: geo.country).first if geo
  end

  after_validation :geocode # auto-fetch coordinates
  after_validation :reverse_geocode # auto-fetch country

  with_options presence: true, if: :must_have_address? do
    validates :latitude
    validates :longitude
    validates :country
  end

  scope :service_providers, -> { joins(spree_role_users: :spree_roles).where('spree_roles.name IN ?', Spree::Role::SERVICE_PROVIDERS) }

  def my_services
    Spree::Product.where(id: orders.joins(:products).pluck('spree_products.id') + followed_services.pluck(:id))
  end

  def can_be_provider?
    Spree::Role::SERVICE_PROVIDERS.any? { |service_provider_role| has_spree_role? service_provider_role }
  end

  def must_have_address?
    latitude.present? || longitude.present? || country.present?
  end

  def want_to_become_pro?
    role_users.any?(&:want_to_become_pro?) && !has_spree_role?('pro_service_provider')
  end

  def pro_service_provider?
    has_spree_role?(:pro_service_provider) || has_spree_role?(:admin)
  end

  def is_service_provider?
    pro_service_provider? || has_spree_role?(:service_provider)
  end

  def paid?
    user? || paid_amount
  end

  def unpaid?
    # (provider? || pro_provider?) && !!paid_amount
    !paid?
  end

  def followed_for?(product)
    follow_services.where(product_id: product.id).exists?
  end

  def supposed_address
    Geocoder.search("#{latitude}, #{longitude}").first.address if latitude && longitude
  end

  def reset_location!
    update! latitude: nil, longitude: nil, country_id: nil
  end

  private

  def make_roles
    service_provider_role = Spree::Role.find_by! name: 'service_provider'

    role_users.find_or_create_by!(role: service_provider_role) do |spree_role_user|
      spree_role_user.want_to_become_pro = pro_provider?
    end

    create_service_provider_rating!
  end
end
