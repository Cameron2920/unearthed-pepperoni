class AddBeaconUuidToEquipment < ActiveRecord::Migration[5.0]
  def change
    add_column :equipment, :beacon_uuid, :string
    add_column :equipment, :beacon_latitude, :float
    add_column :equipment, :beacon_longitude, :float
    add_column :components, :beacon_uuid, :string
    add_column :components, :beacon_latitude, :float
    add_column :components, :beacon_longitude, :float
  end
end
