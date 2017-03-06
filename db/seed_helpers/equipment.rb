module Seed::Equipment
  equipment = {
      shovel: { equipment_type_id: Seed::EquipmentTypes.get(:shovel).id, name: "Haultruck1" }
  }

  @@equipment = {}

  equipment.each do |key, params|
    @@equipment[key] = ::Equipment.find_or_create_by(params)
  end

  def self.get(key)
    @@equipment[key]
  end
end