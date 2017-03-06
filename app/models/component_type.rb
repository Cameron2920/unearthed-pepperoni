class ComponentType < ApplicationRecord
  belongs_to :component_category, :optional => true
  has_many :components
  has_many :issue_types

  validates_presence_of :name
  validates_uniqueness_of :name
end
