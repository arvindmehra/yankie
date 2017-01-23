class RatingsUpdater
  include Sidekiq::Worker

  sidekiq_options queue: :publish, retry: false

  def perform(service_provider_id)
    service_provider = Spree::User.find(service_provider_id)

    service_provider.service_provider_rating.recalculate!
  end
end
