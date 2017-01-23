module Spree
  class NotificationRequestsController < Spree::StoreController
    def create
      @notification_request = build_notification_request(notification_request_params)

      flash['warning'] = @notification_request.errors.full_messages.join('; ') unless @notification_request.save

      redirect_to root_path
    end

    private

    def notification_request_params
      @notification_request_params ||= params.require(:notification_request).permit(:email).dup.merge(
        latitude: cookies['user_latitude'],
        longitude: cookies['user_longitude'],
        string_country: cookies['user_country']
      ).with_indifferent_access
    end

    def build_notification_request(params)
      if spree_current_user
        spree_current_user.notification_requests.build params
      else
        Spree::NotificationRequest.new params
      end
    end
  end
end
