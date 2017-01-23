module Spree
  TaxonsController.class_eval do
    alias_method :old_show, :show

    def show
      old_show

      @products = @products.corresponding_location(
        cookies['user_latitude'], cookies['user_longitude'], cookies['user_country']
      )
    end
  end
end
