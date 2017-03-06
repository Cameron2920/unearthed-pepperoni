class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.boolean :is_reserved

      t.timestamps
    end
  end
end
