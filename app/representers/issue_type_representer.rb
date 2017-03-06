module IssueTypeRepresenter
  include Roar::JSON

  property :id
  property :name
  property :component_type_id
  property :component_name, :getter => lambda {|args| component_type.name}
end
