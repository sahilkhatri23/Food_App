class FranchiseSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :location
  has_many :menu_items
  has_many :orders
end
