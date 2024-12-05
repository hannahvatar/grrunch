class ChangeWeightColumnInProducts < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :weight, :string
  end
end
