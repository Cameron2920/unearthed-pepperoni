module IssueRepresenter
  include Roar::JSON

  property :id
  property :comment
  property :status
  property :priority
  property :created_at
  property :component, :extend => ComponentRepresenter, :class => Component
  property :issue_type, :extend => IssueTypeRepresenter, :class => IssueType
  collection :required_items, :getter => lambda {|args| bill_of_material.bill_of_materials_item_types unless bill_of_material.nil? }, :extend => BillOfMaterialsItemTypeRepresenter, :class => BillOfMaterialsItemType
end
