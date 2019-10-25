class AddNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string, null: false, unique: true
    add_column :users, :fname, :string, null: false 
    add_column :users, :lname, :string, null: false
  end
end
