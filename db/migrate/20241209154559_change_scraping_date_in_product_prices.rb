class ChangeScrapingDateInProductPrices < ActiveRecord::Migration[7.1]
  def change
    change_column :product_prices, :scraping_date, :datetime
  end
end
