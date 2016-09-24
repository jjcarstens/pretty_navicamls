# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160924071528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: :cascade do |t|
    t.string   "address"
    t.boolean  "favorite"
    t.float    "latitude"
    t.float    "list_price"
    t.float    "longitude"
    t.float    "apx_acreage"
    t.integer  "mls_number"
    t.integer  "apx_total_sqft"
    t.string   "picture_url"
    t.integer  "status"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "unit"
    t.string   "county"
    t.string   "subdivision"
    t.string   "elementary_school"
    t.string   "middle_school"
    t.string   "high_school"
    t.string   "style"
    t.integer  "total_bedrooms"
    t.integer  "total_full_baths"
    t.integer  "total_baths"
    t.integer  "apx_year_built"
    t.string   "garage_stalls_type"
    t.integer  "taxes"
    t.string   "tax_year"
    t.string   "sold_price"
    t.string   "sold_date"
    t.string   "construction_status"
    t.string   "exterior_primary"
    t.string   "exterior_secondary"
    t.string   "heat_source_type"
    t.string   "air_conditioning"
    t.string   "foundation"
    t.string   "roof"
    t.string   "water"
    t.string   "sewer"
    t.string   "irrigation"
    t.string   "provider_other_info"
    t.string   "basement"
    t.string   "other_rooms"
    t.string   "laundry"
    t.string   "appliances_included"
    t.string   "fireplace"
    t.string   "interior_features"
    t.string   "exterior_features"
    t.string   "patio_deck"
    t.string   "fence_type_info"
    t.string   "landscaping"
    t.string   "view"
    t.string   "driveway_type"
    t.string   "inclusions"
    t.string   "exclusions"
    t.string   "public_info"
    t.string   "driving_directions_beginning_at"
    t.string   "navica_url"
    t.index ["mls_number"], name: "index_listings_on_mls_number", unique: true, using: :btree
  end

end
