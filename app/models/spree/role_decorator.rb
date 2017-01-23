Spree::Role.class_eval do
  SERVICE_PROVIDERS = ['admin', 'service_provider', 'pro_service_provider'].freeze

  with_options presence: true do
    # validates :name, inclusion: { in: SERVICE_PROVIDERS, allow_blank: true }
  end

  def name
    self[:name].to_s.inquiry
  end
end
