class Store < ApplicationRecord
  has_many :product_prices
  has_many :products, through: :product_prices

  validates :name, presence: true
end
