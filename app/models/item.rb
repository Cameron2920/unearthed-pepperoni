class Item < ApplicationRecord

  scope :available_items, -> {where(:is_reserved => false)}
  belongs_to :item_type, counter_cache: true

  validates_presence_of :item_type
  validates_inclusion_of :is_reserved, :in => [true, false]

  before_validation do
    if self.is_reserved.nil?
      self.is_reserved = false
    end
  end
end
