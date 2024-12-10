class DropProductStoresTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :product_stores
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
