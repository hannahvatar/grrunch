class Product < ApplicationRecord
  belongs_to :list
  has_many :product_prices
  has_many :product_stores
end
