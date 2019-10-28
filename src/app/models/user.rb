class User < ApplicationRecord
  has_one :address
  has_many :listings
  has_one :order
  accepts_nested_attributes_for :address
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
