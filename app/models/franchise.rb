class Franchise < ApplicationRecord
  has_many :menu_items, dependent: :destroy
  belongs_to :user
  has_many :orders
end
