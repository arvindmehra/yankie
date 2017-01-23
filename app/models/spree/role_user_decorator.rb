Spree::RoleUser.class_eval do
  acts_as_paranoid

  has_one :subscribe_request, dependent: :nullify

  delegate :name, to: :role

  with_options presence: true do
    validates :until_date, if: -> { name.pro_service_provider? }
  end

  validates :want_to_become_pro, inclusion: { in: [true, false] }

  scope :have_until_date, -> { where.not(until_date: nil) }
  scope :have_not_until_date, -> { where(until_date: nil) }
  scope :expired, -> { have_until_date.where('until_date < ?', Time.zone.now) }
  scope :not_expired, -> { where('until_date is NULL OR until_date > ?', Time.zone.now) }

  after_initialize :add_want_to_become_pro, if: :new_record?

  def have_until_date
    until_date.present?
  end

  def have_not_until_date
    until_date.blank?
  end

  def expired?
    (have_until_date && until_date < Time.zone.now).to_b
  end

  def not_expired?
    (have_not_until_date || until_date > Time.zone.now).to_b
  end

  private

  def add_want_to_become_pro
    self.want_to_become_pro ||= false
  end
end
