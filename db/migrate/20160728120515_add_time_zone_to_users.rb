class AddTimeZoneToUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :time_zone, :string, default: 'America/New_York', null: false
  end
end
