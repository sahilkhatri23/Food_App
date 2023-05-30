class MenuItem < ApplicationRecord
  belongs_to :franchise
  has_many :orders
  has_many :users, through: :orders
end
