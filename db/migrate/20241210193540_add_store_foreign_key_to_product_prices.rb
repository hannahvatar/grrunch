class AddStoreForeignKeyToProductPrices < ActiveRecord::Migration[7.1]
  def change
    add_reference :product_prices, :store, null: false, foreign_key: true
  end
end
