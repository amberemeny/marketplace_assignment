class ChangeUsersColumn < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:users, :address_id, true)
  end
end
