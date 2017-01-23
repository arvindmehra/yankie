class CreateSpreeProductTimeRanges < ActiveRecord::Migration
  def change
    create_table :spree_product_time_ranges do |t|
      t.references :product, index: true, null: false
      t.integer :week_day
      t.date :specific_date
      t.time :time_from
      t.time :time_to

      t.timestamps null: false
    end
  end
end
