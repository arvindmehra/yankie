class Spree::FollowServicesController < Spree::StoreController
  before_action :authenticate_spree_user!
  before_action :fetch_product

  def create
    @follow_service = spree_current_user.follow_services.new(product: @product)
    @follow_service.save!

    flash['success'] = 'You are following this service'

    redirect_to @product
  end

  def destroy
    @follow_service = spree_current_user.follow_services.where(product_id: @product.id).first
    @follow_service.destroy!

    flash['success'] = 'You are unfollowing this service'

    redirect_to @product
  end

  private

  def fetch_product
    @product ||= Spree::Product.find(params[:product_id])
  end
end
