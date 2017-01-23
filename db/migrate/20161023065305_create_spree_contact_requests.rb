class CreateSpreeContactRequests < ActiveRecord::Migration
  def change
    create_table :spree_contact_requests do |t|
      t.integer :user_id, index: true
      t.string :name, null: false
      t.string :subject, null: false
      t.text :message, null: false
      t.string :phone
      t.string :email
      t.string :state

      t.timestamps null: false
    end

    add_foreign_key :spree_contact_requests, :spree_users, column: :user_id
  end
end
