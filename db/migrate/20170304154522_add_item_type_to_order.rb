class AddItemTypeToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :item_type, index: true, foreign_key: true
    add_column :orders, :expected_arrival_time, :datetime
    add_column :orders, :arrived_at, :datetime
  end
end
