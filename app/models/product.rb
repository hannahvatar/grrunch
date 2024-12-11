class Product < ApplicationRecord
  has_many :product_prices
  has_many :stores, through: :product_prices

  validates :name, :brand, :weight, presence: true

end
