class AddNavicaUrlToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :navica_url, :string
  end
end
