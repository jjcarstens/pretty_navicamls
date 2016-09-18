class AddPictureUrlToListing < ActiveRecord::Migration[5.0]
  def change
    change_table :listings do |l|
      l.string :picture_url
      l.integer :status
      l.timestamps null: false
    end
  end
end
