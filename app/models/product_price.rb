class ProductPrice < ApplicationRecord
  belongs_to :product

  validates :price, presence: true
  # validates :scraping_date, presence: true
  include PgSearch::Model
  pg_search_scope :search_by_price,
    against:  [ :price ],
    using: {
      tsearch: { prefix: true }
    }
end
