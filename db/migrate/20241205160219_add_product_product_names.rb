class AddProductProductNames < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :product_name, :string
  end
end
