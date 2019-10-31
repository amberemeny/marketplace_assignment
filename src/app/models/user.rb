class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  has_one :address
  has_many :listings
  has_one :order
  accepts_nested_attributes_for :address
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def assign_default_role
    add_role(:user) if roles.blank?
  end
  
end
