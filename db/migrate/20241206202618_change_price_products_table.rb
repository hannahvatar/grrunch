class ChangePriceProductsTable < ActiveRecord::Migration[7.1]
  def change
    change_column :product_prices, :price, :string
  end
end
