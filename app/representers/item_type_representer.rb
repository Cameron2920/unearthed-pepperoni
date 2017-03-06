module ItemTypeRepresenter
  include Roar::JSON
  
  property :id
  property :name
  property :available_count
  property :reserved_count
end
