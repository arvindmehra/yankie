class AddUntilDateToRoles < ActiveRecord::Migration
  def change
    add_column :spree_role_users, :until_date, :date
    add_column :spree_role_users, :want_to_become_pro, :boolean, default: false, null: false
  end
end
