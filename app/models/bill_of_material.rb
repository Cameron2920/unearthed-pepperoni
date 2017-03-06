class BillOfMaterial < ApplicationRecord
  belongs_to :issue_type, optional: true
  has_many :bill_of_materials_item_types
  has_and_belongs_to_many :item_types, :through => :bill_of_materials_item_types
end
