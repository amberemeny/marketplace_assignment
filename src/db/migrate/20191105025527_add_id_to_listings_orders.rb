class AddIdToListingsOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :listings_orders, :id, :primary_key
  end
end
