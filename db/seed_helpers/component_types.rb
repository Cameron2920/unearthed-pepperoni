module Seed::ComponentTypes
  components = {
      tire: { name: 'Tire' },
      engine: { name: 'Engine' },
      windshield: { name: 'Windshield' }
  }

  @@components = {}

  components.each do |key, params|
    @@components[key] = ComponentType.find_or_create_by(params)
  end

  def self.get(key)
    @@components[key]
  end
end