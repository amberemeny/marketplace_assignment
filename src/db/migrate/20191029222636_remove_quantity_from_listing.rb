class RemoveQuantityFromListing < ActiveRecord::Migration[6.0]
  def change

    remove_column :listings, :quantity, :integer
  end
end
