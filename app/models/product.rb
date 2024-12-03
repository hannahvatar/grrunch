class Product < ApplicationRecord
  belongs_to :list
  has_many :product_prices
  has_many :product_stores
  has_many :stores, through: :product_stores

  validates :name, :brand, :weight, presence: true
end
