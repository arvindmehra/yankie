class CreateSpreeFollowServices < ActiveRecord::Migration
  def change
    create_table :spree_follow_services do |t|
      t.references :user, index: true, null: false
      t.references :product, index: true, null: false

      t.timestamps null: false
    end
  end
end
