class EndProSubscription
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options queue: :publish, retry: 10

  recurrence { daily.hour_of_day(5) }

  def perform
    pro_service_provider_role = Spree::Role.where(name: 'pro_service_provider').first

    # Do not use destroy_all
    pro_service_provider_role.role_users.expired.each &:destroy
  end
end
