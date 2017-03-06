class CreateBillOfMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :bill_of_materials do |t|
      t.timestamps
    end
  end
end
