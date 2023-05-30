class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.belongs_to :menu_item

      t.timestamps
    end
  end
end
