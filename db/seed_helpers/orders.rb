module Seed::Orders
  orders = {
      replacement_tire: { item_type: Seed::ItemTypes.get(:replacement_tire), :item_count => 2},
      nut: { item_type: Seed::ItemTypes.get(:nut), :item_count => 200}
  }

  @@issue_types= {}

  orders.each do |key, params|
    @@issue_types[key] = Order.create(params)
  end

  def self.get(key)
    @@issue_types[key]
  end
end