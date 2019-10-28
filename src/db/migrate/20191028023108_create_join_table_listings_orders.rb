class CreateJoinTableListingsOrders < ActiveRecord::Migration[6.0]
  def change
    create_join_table :listings, :orders do |t|
      # t.index [:listing_id, :order_id]
      # t.index [:order_id, :listing_id]
    end
  end
end
