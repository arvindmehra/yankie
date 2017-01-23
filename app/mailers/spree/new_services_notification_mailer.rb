module Spree
  class NewServicesNotificationMailer < BaseMailer
    def notify(notification_request, product)
      @notification_request = notification_request.respond_to?(:id) ? notification_request : Spree::NotificationRequest.find(notification_request)
      @product = product.respond_to?(:id) ? product : Spree::Product.find(product)
      subject = 'A new service for you and your geolocation'
      mail(to: @notification_request.email, from: from_address, subject: subject)
    end
  end
end
