class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.integer :status
      t.text :comment

      t.timestamps
    end
  end
end
