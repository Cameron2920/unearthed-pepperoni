module BillOfMaterialsItemTypeRepresenter
  include Roar::JSON
  
  property :count, :getter => lambda {|args| item_type_count}
  property :item, :getter => lambda {|args| item_type}, :extend => ItemTypeRepresenter, :class => ItemType
end
