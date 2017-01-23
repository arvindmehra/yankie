class AbilityDecorator
  include CanCan::Ability

  def initialize(user)
    set_role_guest

    if user
      user.spree_roles.each do |spree_role|
        method = "set_role_#{spree_role.name}"
        send(method, user) if respond_to? method
      end
    end
  end

  def set_role_admin(user)
    set_role_pro_service_provider(user)
  end


  def set_role_pro_service_provider(user)
    set_role_service_provider(user)

    can [:display, :admin, :edit, :cart], Spree::Order

    can [:change_state, :admin], Spree::LineItem, variant: { product: { service_provider_id: user.id } }
  end

  def set_role_service_provider(user)
    set_role_user(user)
    # do not need compare ids. It is doing in controller.
    can [:display, :admin], Spree::SubscribeRequest
    can :create, Spree::SubscribeRequest if user.subscribe_request.blank?
    can [:manage, :admin], Spree::Product, service_provider_id: user.id
    can [:create, :admin], Spree::Product
    can [:modify, :admin], Spree::Variant, product: { service_provider_id: user.id }
    can [:display, :admin], Spree::Taxon
    can [:modify, :admin], Spree::Classification
    cannot [:destoy, :admin],Spree::User,id:user.id
    cannot [:create, :admin],Spree::User,id:user.id
    cannot [:new, :admin],Spree::User,id:user.id
    can [:manage, :admin], Spree::User,id:user.id
  end

  def set_role_user(user)
    set_role_guest
  end

  def set_role_guest(user = nil)
  end

  # #############################
  # can :destroy, LineItem do |item|
  #   item.order.user == user
  # end
  # #############################
  # can :read, Artwork do |artwork|
  #   artwork.order && artwork.order.user == user
  # end
  # can :update, Artwork do |artwork|
  #   artwork.order && artwork.order.user == user
  # end
  # #############################
  # can :read, ArtworkRevision do |revision|
  #   revision.order && revision.order.user == user
  # end
  # can :update, ArtworkRevision do |revision|
  #   revision.order && revision.order.user == user
  # end
end

Spree::Ability.register_ability(AbilityDecorator)
