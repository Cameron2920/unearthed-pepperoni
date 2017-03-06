class CreateComponentCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :component_categories do |t|
      t.string :name

      t.timestamps
    end

    add_reference :component_types, :component_category, index: true, foreign_key: true
  end
end
