class AddDurationTimeToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :duration, :time, null: false, default: Time.zone.now.beginning_of_day
  end
end
