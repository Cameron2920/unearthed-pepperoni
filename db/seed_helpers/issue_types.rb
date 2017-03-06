module Seed::IssueTypes
  issue_types = {
      flat_tire: { name: 'Flat Tire', component_type: Seed::ComponentTypes.get(:tire),  bill_of_material: Seed::BillOfMaterials.get(:flat_tire), priority: 3},
      chipped_windshield: { name: 'Chipped Windshield', component_type: Seed::ComponentTypes.get(:windshield),  bill_of_material: Seed::BillOfMaterials.get(:chipped_windshield), priority: 3},
      smashed_windshield: { name: 'Smashed Windshield', component_type: Seed::ComponentTypes.get(:windshield),  bill_of_material: Seed::BillOfMaterials.get(:smashed_windshield), priority: 2},
      engine_problem: { name: 'Engine Problem', component_type: Seed::ComponentTypes.get(:engine),  bill_of_material: Seed::BillOfMaterials.get(:engine_problem), priority: 1}
  }

  @@issue_types= {}

  issue_types.each do |key, params|
    @@issue_types[key] = IssueType.create(params)
  end

  def self.get(key)
    @@issue_types[key]
  end
end