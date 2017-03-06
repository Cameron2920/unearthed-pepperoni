class AddItemsCountToItemTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :item_types, :items_count, :integer, default: 0
  end
end
