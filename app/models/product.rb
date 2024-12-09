class Product < ApplicationRecord
  has_one :product_prices
  has_many :product_stores
  has_many :stores, through: :product_stores
  accepts_nested_attributes_for :product_price

  validates :name, :brand, :weight, :price, presence: true
  include PgSearch::Model
  pg_search_scope :search_by_name_and_brand,
    against:  [ :name, :brand, :price, ],
    using: {
      tsearch: { prefix: true }
    }
end
#   against: [ :name ],
#   using: {
#     tsearch: { prefix: true }
#   }
# end
