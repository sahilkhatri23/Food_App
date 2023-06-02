class OrderSerializer < ActiveModel::Serializer
  attributes :id, :menu_item_id, :order_time
  has_many :menu_item
end
