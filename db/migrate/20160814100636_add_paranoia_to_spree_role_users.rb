class AddParanoiaToSpreeRoleUsers < ActiveRecord::Migration
  def change
    add_column :spree_role_users, :deleted_at, :datetime
    add_index :spree_role_users, :deleted_at
  end
end
