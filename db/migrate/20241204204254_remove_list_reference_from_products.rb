class RemoveListReferenceFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_reference :products, :list, index: true, foreign_key: true
  end
end
