class Order < ApplicationRecord
  belongs_to :user
  belongs_to :menu_item
  belongs_to :franchise
end