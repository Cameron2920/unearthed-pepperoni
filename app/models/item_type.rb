class ItemType < ApplicationRecord
  has_many :items
  has_and_belongs_to_many :bill_of_materials

  validates_presence_of :name
  validates_uniqueness_of :name

  def reserved_items
    self.items.where(:is_reserved => true)
  end

  def available_items
    self.items.where(:is_reserved => false)
  end

  def available_count
    self.available_items.count
  end

  def reserved_count
    self.reserved_items.count
  end
end
