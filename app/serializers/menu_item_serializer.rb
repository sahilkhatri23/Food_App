class MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :dish_name, :price, :quantity
end
