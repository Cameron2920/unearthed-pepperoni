module OrderRepresenter
  include Roar::JSON

  property :id
  property :item_type_id
  property :item_type_name, :getter => lambda {|args| item_type.name}
  property :item_count
  property :created_at
end
