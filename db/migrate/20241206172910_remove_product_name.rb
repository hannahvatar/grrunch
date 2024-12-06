class RemoveProductName < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :product_name, :string
  end
end
