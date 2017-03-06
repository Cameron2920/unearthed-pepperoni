module Seed::Components
  components = {
      tire: { component_type: Seed::ComponentTypes.get(:tire), equipment: Seed::Equipment.get(:shovel),
              :image_path => Rails.root.join('db','seed_helpers','images', 'tire.jpg') },
      engine: { component_type: Seed::ComponentTypes.get(:engine), equipment: Seed::Equipment.get(:shovel),
                :image_path => Rails.root.join('db','seed_helpers','images', 'engine.jpg')},
      windshield: {component_type: Seed::ComponentTypes.get(:windshield), equipment: Seed::Equipment.get(:shovel),
                   :image_path => Rails.root.join('db','seed_helpers','images', 'windshield.png')}
  }

  @@components = {}

  components.each do |key, params|
    image_path = params.delete(:image_path)
    @@components[key] = Component.find_or_create_by(params)
    Image.create(:parent => @@components[key], :image => open(image_path))
  end

  def self.get(key)
    @@components[key]
  end
end