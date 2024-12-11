class AddPricePer100UnitToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :price_per_100_unit, :string
  end
end
