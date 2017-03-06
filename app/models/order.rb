class Order < ApplicationRecord
  belongs_to :item_type

  scope :outstanding_orders, -> {where(:arrived_at => nil)}

  validates_presence_of :item_count
  validates :item_count, numericality: { greater_than: 0 }

  after_update do
    if self.arrived_at_was.nil? && !self.arrived_at.nil?
      self.add_received_items
    end
  end

  def add_received_items
    Item.create([{:item_type => self.item_type}] * self.item_count)
  end
end
