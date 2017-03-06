module Seed::Issues
  issues = {
      flat_tire: { issue_type: Seed::IssueTypes.get(:flat_tire), :comment => "The tire is flat", :component => Seed::Components.get(:tire)},
      chipped_windshield: { issue_type: Seed::IssueTypes.get(:flat_tire), :component => Seed::Components.get(:windshield)},
      smashed_windshield: { issue_type: Seed::IssueTypes.get(:flat_tire), :component => Seed::Components.get(:windshield)},
      engine_problem: { issue_type: Seed::IssueTypes.get(:flat_tire), :component => Seed::Components.get(:engine), priority: 3}
  }

  @@issue_types= {}

  issues.each do |key, params|
    @@issue_types[key] = Issue.create(params)
  end

  def self.get(key)
    @@issue_types[key]
  end
end