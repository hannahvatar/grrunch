class Product < ApplicationRecord
  belongs_to :list
  has_many :product_prices
  has_many :product_stores
  has_many :stores, through: :product_stores

  validates :name, :brand, :weight, presence: true
  include PgSearch::Model
  multisearchable against: [:name, :brand]
#   against: [ :name ],
#   using: {
#     tsearch: { prefix: true }
#   }
# end
