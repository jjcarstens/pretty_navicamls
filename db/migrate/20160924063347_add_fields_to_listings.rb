class AddFieldsToListings < ActiveRecord::Migration[5.0]
  def change
    change_table :listings do |l|
      l.string :unit
      l.string :county
      l.string :subdivision
      l.string :elementary_school
      l.string :middle_school
      l.string :high_school
      l.string :style
      l.integer :total_bedrooms
      l.integer :total_full_baths
      l.integer :total_baths
      l.integer :apx_year_built
      l.rename :sq_ft, :apx_total_sqft
      l.string :garage_stalls_type
      l.integer :taxes
      l.string :tax_year
      l.string :sold_price
      l.string :sold_date
      l.string :construction_status
      l.string :exterior_primary
      l.string :exterior_secondary
      l.string :heat_source_type
      l.string :air_conditioning
      l.string :foundation
      l.string :roof
      l.string :water
      l.string :sewer
      l.string :irrigation
      l.string :provider_other_info
      l.string :basement
      l.string :other_rooms
      l.string :laundry
      l.string :appliances_included
      l.string :fireplace
      l.string :interior_features
      l.string :exterior_features
      l.string :patio_deck
      l.string :fence_type_info
      l.string :landscaping
      l.string :view
      l.string :driveway_type
      l.rename :lot_size, :apx_acreage
      l.string :inclusions
      l.string :exclusions
      l.string :public_info
      l.string :driving_directions_beginning_at
    end
  end
end
