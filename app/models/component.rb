class Component < ApplicationRecord
  belongs_to :component_type
  belongs_to :equipment, optional: true
  belongs_to :component_category, optional: true
  has_many :issue_types
  has_many :images, as: :parent
end
