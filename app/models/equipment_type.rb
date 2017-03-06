class EquipmentType < ApplicationRecord
  has_many :equipments

  validates_presence_of :name
  validates_uniqueness_of :name
end
