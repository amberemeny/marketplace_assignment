class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :houseno, null: false
      t.string :street, null: false
      t.string :suburb, null: false
      t.string :state, null: false
      t.integer :postcode, null: false

      t.timestamps
    end
  end
end
