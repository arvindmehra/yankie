class CreateSpreeUserFeedbacks < ActiveRecord::Migration
  def change
    create_table :spree_user_feedbacks do |t|
      t.string :text, null: false, default: ''
      t.integer :stars, null: false, default: 1
      t.integer :service_provider_id, index: true, null: false
      t.references :spree_user, foreign_key: true, index: true, null: false
      t.string  :state

      t.timestamps null: false
    end

    add_foreign_key :spree_user_feedbacks, :spree_users, column: :service_provider_id
    add_index :spree_user_feedbacks, [:spree_user_id, :service_provider_id], unique: true, name: 'index_user_feedbacks_on_user_id_and_service_provider_id'
  end
end
