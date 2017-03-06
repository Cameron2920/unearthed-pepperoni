module Seed::BillOfMaterials
  bill_of_materials = {
      flat_tire: {
          bill_of_materials_item_types: [BillOfMaterialsItemType.new({
                                             item_type: Seed::ItemTypes.get(:replacement_tire),
                                             item_type_count: 1
                                         })]
      },
      chipped_windshield: {
          bill_of_materials_item_types: [
              BillOfMaterialsItemType.new({
                                              item_type: Seed::ItemTypes.get(:windshield_goo),
                                              item_type_count: 1
                                          }),
              BillOfMaterialsItemType.new({
                                              item_type: Seed::ItemTypes.get(:windshield_repair_tool),
                                              item_type_count: 1
                                          })
          ]
      },
      smashed_windshield: {
          bill_of_materials_item_types: [
              BillOfMaterialsItemType.new({
                                              item_type: Seed::ItemTypes.get(:replacement_windshield),
                                              item_type_count: 1
                                          }),
              BillOfMaterialsItemType.new({
                                              item_type: Seed::ItemTypes.get(:windshield_repair_tool),
                                              item_type_count: 1
                                          })
          ]
      },
      engine_problem: {
          bill_of_materials_item_types: [
              BillOfMaterialsItemType.new({
                                              item_type: Seed::ItemTypes.get(:nut),
                                              item_type_count: 10
                                          }),
              BillOfMaterialsItemType.new({
                                              item_type: Seed::ItemTypes.get(:bolt),
                                              item_type_count: 10
                                          })
          ]
      }
  }

  @@issue_types= {}

  bill_of_materials.each do |key, params|
    @@issue_types[key] = BillOfMaterial.create(params)
  end

  def self.get(key)
    @@issue_types[key]
  end
end