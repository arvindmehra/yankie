class AddCountryToUsers < ActiveRecord::Migration
  def change
    add_reference :spree_users, :country, index: true
  end
end
