class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.integer :parent_id
      t.string :parent_type
      t.string :tag

      t.timestamps
    end

    add_attachment :images, :image
  end
end
