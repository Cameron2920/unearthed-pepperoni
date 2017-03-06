module ItemTypesRepresenter
  include Representable::JSON::Collection

  items extend: ItemTypeRepresenter
end
