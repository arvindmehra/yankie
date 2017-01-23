class HandleNewVariantLocation
  include Sidekiq::Worker

  sidekiq_options queue: :publish, retry: false

  def perform(variant_location_id)
    variant_location = Spree::VariantLocation.find(variant_location_id)

    Spree::NotificationRequest.in_progress.find_each do |notification_request|
      if variant_location.enough_close?(notification_request.latitude, notification_request.longitude, notification_request.country.name)
        notification_request.fulfill!
        Spree::NewServicesNotificationMailer.delay.notify(notification_request, variant_location.product)
      end
    end
  end
end
