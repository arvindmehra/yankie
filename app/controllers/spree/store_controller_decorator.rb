module Spree
  StoreController.class_eval do
    before_action :check_payment_for_subscription
    # http_basic_authenticate_with name: 'dhh', password: 'secret'
    # before_filter :authenticate_with_basic

    private

    # def authenticate_with_basic
    #   if Rails.env.staging?
    #     authenticate_or_request_with_http_basic do |username, password|
    #       username == 'user' && password == 'password'
    #     end
    #   end
    # end

    def check_payment_for_subscription
      redirect_to pay_for_subscription_users_path if spree_current_user.try(:unpaid?)
    end
  end
end
