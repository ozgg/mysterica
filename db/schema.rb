# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_10_31_075403) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sites", comment: "Sites", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.uuid "uuid", null: false
    t.string "slug", null: false, collation: "C"
    t.string "token", null: false, comment: "Authentication token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((slug)::text)", name: "index_sites_on_lower_slug", unique: true
    t.index ["token"], name: "index_sites_on_token", unique: true
  end
end
