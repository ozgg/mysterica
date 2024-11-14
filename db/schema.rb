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

ActiveRecord::Schema[8.0].define(version: 2024_11_14_124605) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "dream_interpretations", comment: "Dream interpretations", force: :cascade do |t|
    t.uuid "uuid", null: false
    t.bigint "dream_id", null: false
    t.bigint "user_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dream_id"], name: "index_dream_interpretations_on_dream_id"
    t.index ["user_id"], name: "index_dream_interpretations_on_user_id"
    t.index ["uuid"], name: "index_dream_interpretations_on_uuid", unique: true
  end

  create_table "dream_patterns", comment: "Common dream patterns", force: :cascade do |t|
    t.uuid "uuid", null: false
    t.string "name", null: false
    t.string "summary", default: "", null: false, comment: "Summary of interpretation in a couple of sentences"
    t.text "description", null: false, comment: "Detailed description of interpretation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text)", name: "index_dream_patterns_on_lower_name", unique: true
    t.index ["uuid"], name: "index_dream_patterns_on_uuid", unique: true
  end

  create_table "dream_personal_patterns", comment: "Links between dreams and personal patterns", force: :cascade do |t|
    t.bigint "dream_id", null: false
    t.bigint "personal_pattern_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dream_id"], name: "index_dream_personal_patterns_on_dream_id"
    t.index ["personal_pattern_id"], name: "index_dream_personal_patterns_on_personal_pattern_id"
  end

  create_table "dreams", comment: "Dreams", force: :cascade do |t|
    t.uuid "uuid", null: false
    t.bigint "user_id"
    t.bigint "sleep_place_id"
    t.integer "lucidity", limit: 2, default: 0, null: false
    t.integer "privacy", limit: 2, default: 0, null: false
    t.datetime "deleted_at"
    t.string "title"
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date_trunc('month'::text, created_at)", name: "dreams_created_month_idx"
    t.index ["sleep_place_id"], name: "index_dreams_on_sleep_place_id"
    t.index ["user_id"], name: "index_dreams_on_user_id"
    t.index ["uuid"], name: "index_dreams_on_uuid", unique: true
  end

  create_table "personal_patterns", comment: "Personal dream patterns", force: :cascade do |t|
    t.uuid "uuid", null: false
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name"], name: "index_personal_patterns_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_personal_patterns_on_user_id"
    t.index ["uuid"], name: "index_personal_patterns_on_uuid", unique: true
  end

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

  create_table "sleep_places", comment: "Places where dreams are seen", force: :cascade do |t|
    t.uuid "uuid", null: false
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name"], name: "index_sleep_places_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_sleep_places_on_user_id"
    t.index ["uuid"], name: "index_sleep_places_on_uuid", unique: true
  end

  create_table "users", comment: "Users", force: :cascade do |t|
    t.uuid "uuid", null: false
    t.bigint "site_id", comment: "Origin"
    t.string "slug", null: false, collation: "C", comment: "Slug (case-insensitive)"
    t.bigint "inviter_id", comment: "Who invited this user"
    t.boolean "super_user", default: false, null: false, comment: "User has unlimited privileges"
    t.boolean "active", default: true, null: false, comment: "User is allowed to log in"
    t.boolean "bot", default: false, null: false, comment: "User can be handled as bot"
    t.boolean "email_confirmed", default: false, null: false, comment: "Email is confirmed"
    t.string "email", collation: "C", comment: "Primary email"
    t.string "password_digest", null: false, comment: "Encrypted password"
    t.string "notice", comment: "Administrative notice"
    t.string "referral_code", comment: "Referral code"
    t.datetime "deleted_at", comment: "When user was deleted"
    t.jsonb "profile", default: {}, null: false, comment: "Profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((email)::text)", name: "index_users_on_lower_email", unique: true
    t.index "lower((slug)::text)", name: "index_users_on_lower_slug", unique: true
    t.index ["profile"], name: "index_users_on_profile", using: :gin
    t.index ["referral_code"], name: "index_users_on_referral_code", unique: true
    t.index ["site_id"], name: "index_users_on_site_id"
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "dream_interpretations", "dreams", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dream_interpretations", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dream_personal_patterns", "dreams", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dream_personal_patterns", "personal_patterns", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dreams", "sleep_places", on_update: :cascade, on_delete: :nullify
  add_foreign_key "dreams", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "personal_patterns", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sleep_places", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "users", "sites", on_update: :cascade, on_delete: :nullify
  add_foreign_key "users", "users", column: "inviter_id", on_update: :cascade, on_delete: :nullify
end
