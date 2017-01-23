module Spree
  OrdersController.class_eval do
    alias_method :old_populate, :populate
    # after_action :bind_order_with_address,only:[:populate]
    after_action :bind_order_with_address,only:[:populate]
    def update

      if @order.contents.update_cart(order_params)
        respond_with(@order) do |format|
          format.html do
            if params.key?(:checkout)
              @order.next if @order.cart?
              @order.next if @order.address?
              # @order.next if @order.delivery?
              redirect_to checkout_state_path(@order.checkout_steps.third)
            else
              redirect_to cart_path
            end
          end
        end
      else
        respond_with(@order)
      end
    end

    def populate
      if params[:options] && params[:options][:completion_date].present?
        params[:options][:completion_date] += ' ' + params[:options][:completion_time].to_s
        # obviously set nil in order to get validation fail
        params[:options][:completion_date] = nil if params[:options][:completion_time].blank?
      end

      old_populate
    end

    # bind address with order
    def bind_order_with_address
       ship_address = Spree::Address::create(params[:order].require(:ship_address).permit(:firstname, :lastname, :address1, :address2, :city, :country_id, :state_id, :zipcode, :phone))
       current_order.ship_address = ship_address
       current_order.save!
    end

  end
end
