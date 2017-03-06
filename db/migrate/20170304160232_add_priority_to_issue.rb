class AddPriorityToIssue < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :priority, :integer
    add_column :issues, :finished_at, :datetime
    add_column :issue_types, :priority, :integer
  end
end
