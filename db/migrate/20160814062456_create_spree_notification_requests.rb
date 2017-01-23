class CreateSpreeNotificationRequests < ActiveRecord::Migration
  def change
    create_table :spree_notification_requests do |t|
      t.string      :email, null: false
      t.float       :latitude, null: false
      t.float       :longitude, null: false
      t.references  :country, null: false, index: true
      t.references  :user, index: true
      t.boolean     :active, null: false, default: true
      t.boolean     :fulfilled, null: false, default: false

      t.timestamps null: false
    end

    add_foreign_key :spree_notification_requests, :spree_users, column: :user_id
    add_foreign_key :spree_notification_requests, :spree_countries, column: :country_id
  end
end
