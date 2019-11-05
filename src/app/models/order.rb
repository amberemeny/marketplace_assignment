class Order < ApplicationRecord
  belongs_to :user
  has_many :listings_orders
  has_many :listings, through: :listings_orders
end
