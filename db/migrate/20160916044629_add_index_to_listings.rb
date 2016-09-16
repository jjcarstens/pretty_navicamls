class AddIndexToListings < ActiveRecord::Migration[5.0]
  def change
    add_index :listings, :mls_number, unique: true
  end
end
