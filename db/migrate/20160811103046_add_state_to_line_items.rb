class AddStateToLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :state, :string
  end
end
