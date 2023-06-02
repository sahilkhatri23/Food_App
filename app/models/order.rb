class Order < ApplicationRecord
  validates :menu_item_id, :franchise_id, presence: true
  belongs_to :user
  belongs_to :menu_item
  belongs_to :franchise
end