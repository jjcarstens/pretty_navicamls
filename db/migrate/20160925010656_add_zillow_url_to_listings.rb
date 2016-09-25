class AddZillowUrlToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :zillow_url, :string
  end
end
