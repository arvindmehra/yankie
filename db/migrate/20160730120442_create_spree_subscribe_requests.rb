class CreateSpreeSubscribeRequests < ActiveRecord::Migration
  def change
    create_table :spree_subscribe_requests do |t|
      t.integer :salutation
      t.string :firstname
      t.string :initial, limit: 1
      t.string :surname
      t.string :email
      t.date :birth_date
      t.string :mobile_number
      t.string :phone_number
      t.string :fax_number
      t.integer :gender
      t.integer :secret_question
      t.string :secret_answer
      t.string :referred_by
      t.boolean :i_agree
      t.boolean :have_already_account, null: false
      t.string :existing_account_number
      t.integer :address_id, index: true
      t.integer :delivery_address_id, index: true
      t.integer :service_provider_id, index: true, null: false
      t.string  :state
      t.datetime :approved_at
      t.datetime :rejected_at
      t.integer :role_user_id, index: true

      t.timestamps null: false
    end

    add_foreign_key :spree_subscribe_requests, :spree_addresses, column: :address_id
    add_foreign_key :spree_subscribe_requests, :spree_addresses, column: :delivery_address_id
    add_foreign_key :spree_subscribe_requests, :spree_users, column: :service_provider_id
    add_foreign_key :spree_subscribe_requests, :spree_role_users, column: :role_user_id
  end
end
