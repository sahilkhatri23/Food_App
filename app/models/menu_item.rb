class MenuItem < ApplicationRecord
  validates :dish_name, :price, :quantity, presence: true
  belongs_to :franchise
  has_many :orders
  has_many :users, through: :orders
end
