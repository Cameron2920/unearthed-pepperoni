module Seed::ItemTypes
  item_types = {
      replacement_tire: { name: 'Replacement Tire' },
      replacement_windshield: { name: 'Replacement Windshield' },
      windshield_goo: { name: 'Windshield Repair Liquid' },
      windshield_repair_tool: { name: 'Windshield Repair Tool' },
      nut: { name: 'Nut' },
      bolt: { name: 'Bolt' }
  }

  @@item_types = {}

  item_types.each do |key, params|
    @@item_types[key] = ItemType.find_or_create_by(params)
  end

  def self.get(key)
    @@item_types[key]
  end
end