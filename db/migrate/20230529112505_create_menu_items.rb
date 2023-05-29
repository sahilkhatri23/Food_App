class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.string :dish_name
      t.integer :price
      t.string :quantity

      t.timestamps
    end
  end
end
