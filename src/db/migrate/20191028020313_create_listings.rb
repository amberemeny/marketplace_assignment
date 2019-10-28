class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.string :species
      t.text :info
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
