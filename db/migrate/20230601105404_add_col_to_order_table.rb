class AddColToOrderTable < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :order_time, :datetime
    add_reference :orders, :franchise, foreign_key: true
  end
end
