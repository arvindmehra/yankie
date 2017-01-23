module Spree
  Admin::OrdersController.class_eval do
    alias_method :old_index, :index

    def index
      old_index
      @orders = @orders.own_orders(try_spree_current_user.id) unless try_spree_current_user.admin?
    end
  end
end
