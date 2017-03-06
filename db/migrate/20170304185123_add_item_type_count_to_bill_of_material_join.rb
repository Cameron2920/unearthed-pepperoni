class AddItemTypeCountToBillOfMaterialJoin < ActiveRecord::Migration[5.0]
  def change
    add_column :bill_of_materials_item_types, :item_type_count, :integer
  end
end
