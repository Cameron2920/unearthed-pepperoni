class CreateMachineTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :component_types do |t|
      t.string :name

      t.timestamps
    end

    add_reference :components, :component_type, index: true, foreign_key: true
    add_reference :issue_types, :component_type, index: true, foreign_key: true
  end
end
