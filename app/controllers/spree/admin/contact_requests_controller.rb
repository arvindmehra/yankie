module Spree::Admin
  class ContactRequestsController < ResourceController
    helper 'spree/products'

    def index
      @contact_requests = Spree::ContactRequest.all
                                               .ordered
                                               .page(params[:page])
                                               .per(params[:per_page] || Spree::Config[:admin_products_per_page])
    end

    def show
      @contact_request = Spree::ContactRequest.find(params[:id])
    end
  end
end
