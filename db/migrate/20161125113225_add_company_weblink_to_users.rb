class AddCompanyWeblinkToUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :company_description, :text
    add_column :spree_users, :website, :string
  end
end
