class CreateSpreeServiceProviderRatings < ActiveRecord::Migration
  def up
    create_table :spree_service_provider_ratings do |t|
      t.integer :service_provider_id, index: true, null: false
      t.integer :value, null: false, default: 0

      t.timestamps null: false
    end

    add_foreign_key :spree_service_provider_ratings, :spree_users, column: :service_provider_id

    Spree::User.find_each do |user|
      if user.is_service_provider?
        user.create_service_provider_rating!
      end
    end
  end

  def down
    drop_table :spree_service_provider_ratings
  end
end
