module OrdersRepresenter
  include Representable::JSON::Collection

  items extend: OrderRepresenter
end
