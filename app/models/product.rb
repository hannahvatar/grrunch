class Product < ApplicationRecord
  has_many :product_prices
  has_many :product_stores
  has_many :stores, through: :product_stores

  validates :product_name, :name, :brand, :weight, presence: true
  include PgSearch::Model
  pg_search_scope :search_by_name_and_brand,
    against:  [ :product_name, :name, :brand, ],
    using: {
      tsearch: { prefix: true }
    }
end
#   against: [ :name ],
#   using: {
#     tsearch: { prefix: true }
#   }
# end
