class AddCompletionDateToLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :completion_date, :datetime
    add_column :spree_line_items, :details, :text
  end
end
