require 'csv'

namespace :parse_csv_data do
  task generate_data: :environment do
    def parse_component_category_name(csv_component_category_text)
      if csv_component_category_text.nil?
        "UNKNOWN"
      elsif csv_component_category_text.include?(" HAULTRUCK")
        csv_component_category_text.split(" HAULTRUCK").first
      else
        csv_component_category_text
      end
    end

    def map_status_to_issue_status(csv_status_text)
      case csv_status_text.downcase
        when "complete"
          return "finished"
        when "closed"
          return "finished"
      end
      csv_status_text.downcase
    end

    def map_priority_to_issue_priority(csv_priority_text)
      if csv_priority_text.include?("0")
        0
      elsif csv_priority_text.include?("1")
        1
      elsif csv_priority_text.include?("2")
        2
      elsif csv_priority_text.include?("3")
        3
      elsif csv_priority_text.include?("4")
        4
      else
        5
      end
    end

    CSV.foreach(Rails.root.join('lib','tasks','csv_data','work_orders.csv'), :headers => true) do |row|
      work_order_id = row["work_order_id"].to_i
      component_name = row["component_number"]
      equipment_name = row["equipment_number"]
      component_category_name = parse_component_category_name(row["component_category"])
      component_category = ComponentCategory.find_or_create_by(:name => component_category_name)
      equipment_type = EquipmentType.find_or_create_by(:name => equipment_name)
      component_type = ComponentType.find_or_create_by(:name => component_name, :component_category => component_category)
      equipment = Equipment.find_or_create_by(:equipment_type => equipment_type)
      component = Component.find_or_create_by(:equipment => equipment, :component_type => component_type)
      component_type.component_category = component_category
      component_type.save
      issue_type = IssueType.find_or_initialize_by(:component_type => component_type, :name => "HAULTRUCK")
      issue_type.save
      issue = Issue.find_or_initialize_by(:work_report_id => work_order_id, :issue_type => issue_type, :component => component)
      issue.comment = row["comment"]
      issue.created_at = DateTime.parse(row["created_at"]) if row["created_at"] && row["created_at"] != "NULL"
      issue.scheduled_start_date = DateTime.parse(row["scheduled_start_date"]) if row["scheduled_start_date"] && row["scheduled_start_date"] != "NULL"
      issue.scheduled_finished_date = DateTime.parse(row["scheduled_completion_date"]) if row["scheduled_completion_date"] && row["scheduled_completion_date"] != "NULL"
      issue.started_at = DateTime.parse(row["actual_start_date"]) if row["actual_start_date"] && row["actual_start_date"] != "NULL"
      issue.estimated_hours = row["estimated_hours"].to_i if row["estimated_hours"] && row["estimated_hours"] != "NULL"
      issue.actual_hours = row["actual_hours"].to_i if row["actual_hours"] && row["actual_hours"] != "NULL"
      issue.finished_at = DateTime.parse(row["finished_at"]) if row["finished_at"] && row["finished_at"] != "NULL"
      issue.status = map_status_to_issue_status(row["status"])
      issue.priority = map_priority_to_issue_priority(row["priority"])
      issue.was_planned_maintenance = row["was_planned_maintenance"] == "true"
      issue.requires_shutdown_of_equipment = row["did_require_shutdown"] == "true"
      # issue.activity_type = row["activity_type"]
      issue.save
    end

    CSV.foreach(Rails.root.join('lib','tasks','csv_data','work_order_costs.csv'), :headers => true) do |row|
      work_order_id = row["work_order_id"].to_i
      issue = Issue.find_by_work_report_id(work_order_id)

      if issue
        issue.total_cost = row["total_cost"].to_i if row["total_cost"] && row["total_cost"] != "NULL"
        issue.save
      end
    end
  end
end
