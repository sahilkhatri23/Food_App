class AddColumnToMenuItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :menu_items, :franchise, foreign_key: true
  end
end
