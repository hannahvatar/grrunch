class CreateProductPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :product_prices do |t|
      t.integer :price
      t.date :scraping_date
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
