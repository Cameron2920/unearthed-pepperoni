class BillOfMaterialsItemType < ApplicationRecord
  belongs_to :item_type
  belongs_to :bill_of_material

  validates_presence_of :item_type_count
end
