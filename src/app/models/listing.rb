class Listing < ApplicationRecord
  belongs_to :user
  has_many :listings_orders
  has_many :orders, through: :listings_orders
  has_one_attached :image
end
