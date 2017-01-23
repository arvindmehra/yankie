module Spree
  ProductsController.class_eval do
    alias_method :old_show, :show
    alias_method :old_index, :index
    include ApplicationHelper
    before_action :load_product, only: [:show, :available_time_for_day]

    def available_time_for_day
      render json: @product.product_time_ranges.available_time_for(
        Date.strptime(params[:date], '%Y/%m/%d')
      )
    end

    def index
      old_index

      @products = @products.corresponding_location(
        cookies['user_latitude'], cookies['user_longitude'], cookies['user_country']
      )
    end

    def show
          address = Spree::Address.new
          if cookies[:location_confirmed].present?
            data = get_current_address
            # raise Spree::Country.find_by_iso_name(data.country.upcase).inspect
            address.firstname = cookies[:first_name]
            address.lastname = cookies[:last_name]
            address.address1 = data.address.split(",")[0]+","+data.address.split(",")[1]
            address.address2 = data.route
            address.city = data.city
            address.state = Spree::State.find_by_name(data.state)
            address.country = Spree::Country.find_by_iso_name(data.country.upcase)
            address.zipcode =  data.postal_code
            address.phone = cookies[:phone]
          end
          @address_obj = address

          gon.available_days = build_available_days
          old_show
    end

    private

    def build_available_days
      available_days = {}

      (Date.current..(Date.current + 1.month).end_of_month).each do |day|
        available_days[day] = @product.available_for?(day)
      end

      available_days
    end
  end
end
