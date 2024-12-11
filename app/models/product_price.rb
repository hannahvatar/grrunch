class ProductPrice < ApplicationRecord
  belongs_to :product
  belongs_to :store

  validates :price, presence: true
  # validates :scraping_date, presence: true
  include PgSearch::Model
  pg_search_scope :search_by_name_and_brand,
    associated_against: {
      product: [:name, :brand]
}
end
