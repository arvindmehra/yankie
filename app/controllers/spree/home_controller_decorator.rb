module Spree
  HomeController.class_eval do
    alias_method :old_index, :index

    def index
      old_index
      @products = @products.corresponding_location(
        cookies['user_latitude'], cookies['user_longitude'], cookies['user_country']
      )
    end
  end
end
