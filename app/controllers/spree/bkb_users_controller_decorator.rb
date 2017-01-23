# module Spree
#   UsersController.class_eval do
#     before_action :authenticate_spree_user!, only: [
#         :unfollow_service, :follow_service, :services, :pay_for_subscription,
#       :paying_for_subscriptio
#     ]

#     skip_before_action :check_payment_for_subscription, only: [:pay_for_subscription, :paying_for_subscription]

#     def my_services
#       @my_services = spree_current_user ? spree_current_user.my_services : Spree::Product.none
#     end

#     def pay_for_subscription
#       @pay_for_subscription = Forms::PayForSubscription.find spree_current_user.id
#       build_associations
#     end

#     def paying_for_subscription
#       @pay_for_subscription = Forms::PayForSubscription.find spree_current_user.id
#       @pay_for_subscription.assign_nested_attributes pay_for_subscription_params

#       if @pay_for_subscription.call
#         redirect_to spree.root_path
#       else
#         render :pay_for_subscription
#       end
#     end

#     def confirm_location
#       cookies[:location_confirmed] = true

#       if spree_current_user
#         spree_current_user.update_attributes(
#           latitude: cookies['user_latitude'],
#           longitude: cookies['user_longitude'],
#           country: Spree::Country.where(name: cookies['user_country']).first
#         )
#       end

#       redirect_to spree.root_path
#     end

#     def edit_location
#       # if not location - return
#       # return if spree_current_user.supposed_address
#       # return if current_address
#       # return
#       reset_location
#       # redirect_to spree.root_path
#     end

#     def reset_location
#       # spree_current_user.reset_location!
#       cookies[:location_confirmed] = nil
#       cookies[:latitude] = nil
#       cookies[:longitude] = nil
#       cookies[:location_confirmed] = nil
#       redirect_to spree.root_path
#     end

#     def set_location
#       user_location = Geocoder.search(user_location_params).first
#       if user_location
#         cookies[:user_latitude] = user_location.latitude
#         cookies[:user_longitude] = user_location.longitude
#         cookies[:user_country] = user_location.country
#         cookies[:location_confirmed] = true
#       end
#       # spree_current_user.update_attributes(user_location_params) if spree_current_user
#       redirect_to spree.root_path
#     end

#     def services
#       spree_current_user
#     end

#     def follow_service
#       Spree::FollowSerive.create user: spree_current_user, product_id: params[:product_id]
#       render nothing: true
#     end

#     def unfollow_service
#       Spree::FollowSerive.find_by(user: spree_current_user, product_id: params[:product_id]).destroy
#       render nothing: true
#     end

#     def show_map
#       p 111111111111111111111
#       p params.inspect
#       p 2222222222222222222222222
#       p request.inspect
#       p 111111111111111111111
#       @coords = if params[:latitude] && params[:longitude]
#         {
#           latitude: params[:latitude],
#           longitude: params[:longitude],
#           country: Geocoder.search("#{params[:latitude]}, #{params[:longitude]}").first.try(:country) || request.location.country
#         }
#       else
#         {
#           latitude: request.location.latitude,
#           longitude: request.location.longitude,
#           country: request.location.country
#         }
#       end
#     end

#     private

#     def user_location_params
#       params.require(:user).permit(:address)
#     end

#     def build_associations
#       country_id = Address.default.country.id
#       @pay_for_subscription.build_ship_address(country_id: country_id) if @pay_for_subscription.ship_address.nil?
#       @pay_for_subscription.ship_address.country_id = country_id if @pay_for_subscription.ship_address.country.nil?
#     end

#     def pay_for_subscription_params
#       params
#         .require(:user)
#         .permit(ship_address_attributes: permitted_address_attributes, credit_card: PermittedAttributes.source_attributes)
#     end
#   end
# end
