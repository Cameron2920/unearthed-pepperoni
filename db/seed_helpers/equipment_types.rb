module Seed::EquipmentTypes
  equipment = {
      shovel: { name: 'Shovel' }
  }

  @@equipment = {}

  equipment.each do |key, params|
    @@equipment[key] = ::EquipmentType.find_or_create_by(params)
  end

  def self.get(key)
    @@equipment[key]
  end
end