class RanameUserField < ActiveRecord::Migration
  def change
    rename_column :spree_users, :wanted_to_became, :wanted_to_become
  end
end
