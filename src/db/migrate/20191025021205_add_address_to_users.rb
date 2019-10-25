class AddAddressToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :address, null: false, foreign_key: true
  end
end
