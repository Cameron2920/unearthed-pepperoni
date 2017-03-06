class AddNameToEquipment < ActiveRecord::Migration[5.0]
  def change
    add_column :equipment, :name, :string

    Equipment.all.each do |equipment|
      equipment.name = equipment.equipment_type.name + equipment.id.to_s
      equipment.save
    end
  end
end
