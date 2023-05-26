class Franchise < ApplicationRecord
  has_many :menuItems, dependent: :destroy
  belongs_to :user
end
