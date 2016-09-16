class CreateListingsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :address
      t.boolean :favorite
      t.decimal :latitude
      t.decimal :list_price
      t.decimal :longitude
      t.decimal :lot_size
      t.integer :mls_number
      t.integer :sq_ft
    end
  end
end
