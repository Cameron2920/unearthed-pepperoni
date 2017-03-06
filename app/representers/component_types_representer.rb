module ComponentTypesRepresenter
  include Representable::JSON::Collection

  items extend: ComponentTypeRepresenter
end
