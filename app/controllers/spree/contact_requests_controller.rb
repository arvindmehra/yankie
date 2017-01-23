class Spree::ContactRequestsController < Spree::StoreController
  def new
    @contact_request = Spree::ContactRequest.new
  end

  def create
    @contact_request      = Spree::ContactRequest.new(contact_request_params)
    @contact_request.user = spree_current_user if spree_current_user

    if @contact_request.save
      flash['success'] = 'Your contact request has been submitted'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def contact_request_params
    @contact_request_params ||= params.require(:contact_request).permit(:subject, :message, :email, :phone, :name)
  end
end
