module Spree
  module Admin
    class SubscribeRequestsController < ResourceController
      before_action :show_existed, only: [:new]
      before_action :load_subscribe_request, only: [:show, :change_state, :update]

      helper_method :subscribe_request_url

      def new
        @subscribe_request = spree_current_user.build_subscribe_request
        build_associations
      end

      def create
        @subscribe_request = spree_current_user.create_subscribe_request(subscribe_request_params)

        if @subscribe_request.save!
          redirect_to @subscribe_request
        else
          build_associations
          render :new
        end
      end

      def update
        if @subscribe_request.update(subscribe_request_params)
          redirect_to @subscribe_request
        else
          build_associations
          render :show
        end
      end

      def index
        @subscribe_requests = subscribe_requests_scope
                              .page(params[:page])
                              .per(params[:per_page] || Spree::Config[:admin_products_per_page])
      end

      def show
        @disabled = true
        build_associations
        render :new
      end

      def change_state
        if @subscribe_request.state_events.include?(params[:new_state].to_s.to_sym)
          @subscribe_request.send(params[:new_state])
        end

        redirect_to admin_subscribe_requests_path
      end

      private

      def load_subscribe_request
        @subscribe_request = subscribe_requests_scope.find params[:id]
      end

      def show_existed
        if spree_current_user.subscribe_request
          redirect_to spree_current_user.subscribe_request
        end
      end

      def build_associations
        country_id = Address.default.country.id
        @subscribe_request.build_address(country_id: country_id) if @subscribe_request.address.nil?
        @subscribe_request.build_delivery_address(country_id: country_id) if @subscribe_request.delivery_address.nil?

        @subscribe_request.address.country_id = country_id if @subscribe_request.address.country.nil?
        @subscribe_request.delivery_address.country_id = country_id if @subscribe_request.delivery_address.country.nil?

        @subscribe_request.build_legal_identification if @subscribe_request.legal_identification.nil?
        @subscribe_request.build_legal_business_document if @subscribe_request.legal_business_document.nil?
      end

      def subscribe_request_url(*args)
        admin_subscribe_request_path(args)
      end

      def subscribe_requests_scope
        spree_current_user.admin? ? Spree::SubscribeRequest.all : spree_current_user.subscribe_requests
      end

      def subscribe_request_params
        params.require(:subscribe_request).permit(:salutation, :firstname, :surname, :birth_date,
                                                  :existing_account_number, :api_key, :api_passphrase,
                                                  :mobile_number, :gender, :secret_question, :secret_answer, :email,
                                                  :firstname, :i_agree, :legal_identification, :fax_number,
                                                  :have_already_account, :phone_number, :api_merchant_code,
                                                  :delivery_address, :use_address, :initial, :referred_by,
                                                  legal_business_document_attributes: [:attachment],
                                                  legal_identification_attributes: [:attachment],
                                                  address_attributes: permitted_address_attributes,
                                                  delivery_address_attributes: permitted_address_attributes)
      end

      def load_subscribe_requests
        @subscribe_requests = spree_current_user.subscribe_request
      end
    end
  end
end
