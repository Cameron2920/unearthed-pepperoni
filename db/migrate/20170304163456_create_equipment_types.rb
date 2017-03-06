class CreateEquipmentTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :equipment_types do |t|
      t.string :name

      t.timestamps
    end
    add_reference :equipment, :equipment_type, index: true, foreign_key: true
  end
end
