class AddReferencesToTables < ActiveRecord::Migration[5.0]
  def change
    add_reference :items, :item_type, index: true, foreign_key: true
    add_reference :bill_of_materials, :issue_type, index: true, foreign_key: true
    add_reference :issues, :issue_type, index: true, foreign_key: true
    add_reference :item_types, :order, index: true, foreign_key: true
    add_reference :components, :equipment, index: true, foreign_key: true
    add_reference :issues, :component, index: true, foreign_key: true

    create_table :bill_of_materials_item_types, :id => false do |t|
      t.integer :bill_of_material_id
      t.integer :item_type_id
    end
  end
end
