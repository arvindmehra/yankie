class AddServiceProviderToProduct < ActiveRecord::Migration
  def up
    add_column :spree_products, :service_provider_id, :integer

    Spree::Product.find_each do |product|
      product.update_column :service_provider_id, Spree::User.first.id
    end

    change_column_null :spree_products, :service_provider_id, false
  end

  def down
    remove_column :spree_products, :service_provider_id
  end
end
