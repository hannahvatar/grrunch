class Store < ApplicationRecord
  has_many :product_stores, dependent: :destroy
  has_many :products, through: :product_stores

  validates :name, presence: true
end
