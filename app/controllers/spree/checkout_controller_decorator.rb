module Spree
  CheckoutController.class_eval do
    # Updates the order and advances to the next state (when possible.)
    def update
      if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
        @order.temporary_address = !params[:save_user_address]
        unless @order.next
          flash[:error] = @order.errors.full_messages.join("\n")
          redirect_to(checkout_state_path(@order.state)) && return
        end

        @current_order = nil
        flash.notice = Spree.t(:order_processed_successfully)
        flash['order_completed'] = true
        redirect_to root_path
      else
        render :edit
      end
    end

    private

    alias_method :old_before_payment, :before_payment

    def before_payment
      before_address
      old_before_payment
    end
  end
end
