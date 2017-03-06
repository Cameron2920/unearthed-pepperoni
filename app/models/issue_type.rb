class IssueType < ApplicationRecord
  belongs_to :component_type
  has_one :bill_of_material
  has_many :issues

  accepts_nested_attributes_for :bill_of_material

  validates_presence_of :name
  validates_presence_of :bill_of_material
  validates_uniqueness_of :name, :scope => :component_type_id
  validates_presence_of :priority
  validates :priority, numericality: { greater_than_or_equal_to: 0 }

  before_validation do
    if self.priority.nil?
      self.priority = 3
    end
  end
end
