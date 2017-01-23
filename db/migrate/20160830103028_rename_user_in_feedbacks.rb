class RenameUserInFeedbacks < ActiveRecord::Migration
  def change
    rename_column :spree_user_feedbacks, :spree_user_id, :user_id
  end
end
