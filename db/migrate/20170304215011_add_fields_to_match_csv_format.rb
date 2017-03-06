class AddFieldsToMatchCsvFormat < ActiveRecord::Migration[5.0]
  def change
    add_column :issues, :work_report_id, :integer
    add_column :issues, :scheduled_start_date, :datetime
    add_column :issues, :scheduled_finished_date, :datetime
    add_column :issues, :started_at, :datetime
    add_column :issues, :estimated_hours, :integer
    add_column :issues, :actual_hours, :integer
    add_column :issues, :was_planned_maintenance, :boolean
    add_column :issues, :requires_shutdown_of_equipment, :boolean
    add_column :issues, :activity_type, :integer
    add_column :issues, :total_cost, :integer
  end
end
