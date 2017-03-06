module EquipmentRepresenter
  include Roar::JSON

  property :id
  property :beacon_uuid
  property :beacon_latitude
  property :beacon_longitude
  property :name
  collection :images, :extend => ImageRepresenter, :class => Image
end
