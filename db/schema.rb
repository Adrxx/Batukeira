# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150903141647) do

  create_table "cases", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "eleapsed_time"
    t.decimal  "waist_before"
    t.decimal  "waist_after"
    t.decimal  "weight_before"
    t.decimal  "weight_after"
    t.string   "product_used"
    t.boolean  "featured",      default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "contact_models", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dealers", force: :cascade do |t|
    t.string   "name"
    t.string   "telephone"
    t.boolean  "hidden_telephone"
    t.string   "telephone2"
    t.boolean  "hidden_telephone2"
    t.string   "email"
    t.boolean  "hidden_email"
    t.text     "address"
    t.boolean  "hidden_address"
    t.text     "visible_address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "photos", force: :cascade do |t|
    t.text     "description"
    t.integer  "year"
    t.integer  "month"
    t.decimal  "weight"
    t.integer  "order"
    t.string   "photo_file_file_name"
    t.string   "photo_file_content_type"
    t.integer  "photo_file_file_size"
    t.datetime "photo_file_updated_at"
    t.integer  "case_id"
  end

  add_index "photos", ["case_id"], name: "index_photos_on_case_id"

  create_table "preferences", force: :cascade do |t|
    t.text   "values"
    t.text   "facebook"
    t.text   "twitter"
    t.string "telephone"
    t.string "telephone2"
    t.string "email"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.integer  "role",                   default: 0
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
