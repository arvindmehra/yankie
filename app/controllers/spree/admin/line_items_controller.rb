module Spree
  module Admin
    class LineItemsController < ResourceController
      def change_state
        @line_item.public_send(params[:event]) if @line_item.state_events.include? params[:event].to_sym
        flash[:notice] = 'The state has been changed successfully'
        flash[:notice] = Spree.t(:fill_in_customer_info)
        redirect_to location_after_save
      end

      private

      def location_after_save
        cart_admin_order_path(@line_item.order)
      end
    end
  end
end
