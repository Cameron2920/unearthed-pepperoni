module ComponentsRepresenter
  include Representable::JSON::Collection

  items extend: ComponentRepresenter
end
