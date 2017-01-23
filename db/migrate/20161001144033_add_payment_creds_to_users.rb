class AddPaymentCredsToUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :api_key, :string
    add_column :spree_users, :api_merchant_code, :string
    add_column :spree_users, :api_passphrase, :string

    add_column :spree_subscribe_requests, :api_key, :string
    add_column :spree_subscribe_requests, :api_merchant_code, :string
    add_column :spree_subscribe_requests, :api_passphrase, :string
  end
end
