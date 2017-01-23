class CreateSpreeVariantLocations < ActiveRecord::Migration
  def change
    create_table :spree_variant_locations do |t|
      t.references :variant, index: true, null: false
      t.references :country, index: true
      t.float :latitude, null: false, default: 0
      t.float :longitude, null: false, default: 0
      t.float :radius_km, null: false, default: 0
      t.string :address, null: false, default: ''
      t.integer :kind, null: false

      t.timestamps null: false
    end

    add_index :spree_variant_locations, [:latitude, :longitude]
  end
end
