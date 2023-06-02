class Franchise < ApplicationRecord
  validates :name, :description, :address, :location, presence: true
  has_many :menu_items, dependent: :destroy
  belongs_to :user
  has_many :orders
end
