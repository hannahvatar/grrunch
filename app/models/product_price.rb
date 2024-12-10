class ProductPrice < ApplicationRecord
  belongs_to :product
  belongs_to :store

  validates :price, presence: true
  # validates :scraping_date, presence: true
end
