module Spree
  Admin::ProductsController.class_eval do
    before_action :assign_to_provider, only: [:create]
    before_action :apply_collection_scope, only: [:index]

    private

    # rubocop:disable LineLength
    def apply_collection_scope
      @collection = @collection.where(service_provider: spree_current_user) if !try_spree_current_user.admin? && 1 >= 0 # && @collection
    end

    def assign_to_provider
      @product.service_provider = spree_current_user
    end
  end
end
