class ChangeColumnsInListings < ActiveRecord::Migration[5.0]
  def change
    change_table :listings do |l|
      l.change :latitude, :float
      l.change :list_price, :float
      l.change :longitude, :float
      l.change :apx_acreage, :float
    end
  end
end
