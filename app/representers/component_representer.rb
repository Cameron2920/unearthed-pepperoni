module ComponentRepresenter
  include Roar::JSON

  property :id
  property :beacon_uuid
  property :beacon_latitude
  property :beacon_longitude
  property :equipment, :extend => EquipmentRepresenter, :class => Equipment
  property :name, :getter => lambda {|args| component_type.name}
  property :component_type_id
  property :created_at
  property :updated_at
  property :image_url, getter: lambda {|args| images.first.image_url unless images.first.nil?}
  collection :images, :extend => ImageRepresenter, :class => Image
end
