class ProductPrice < ApplicationRecord
  belongs_to :product

  validates :price, presence: true
  validates :scraping_date, presence: true
end
