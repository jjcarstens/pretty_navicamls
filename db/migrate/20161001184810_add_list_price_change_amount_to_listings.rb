class AddListPriceChangeAmountToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :list_price_change_amount, :float
  end
end
