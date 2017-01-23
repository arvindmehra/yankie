class AddFiledsInUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :wanted_to_became, :integer, default: 0, null: false
    add_column :spree_users, :paid_amount, :decimal, precision: 5, scale: 2
  end
end
