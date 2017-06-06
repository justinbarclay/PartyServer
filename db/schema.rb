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

ActiveRecord::Schema.define(version: 20170606144416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "part_histories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "change"
    t.integer  "part_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_id"], name: "index_part_histories_on_part_id", using: :btree
    t.index ["user_id"], name: "index_part_histories_on_user_id", using: :btree
  end

  create_table "parts", force: :cascade do |t|
    t.string   "name"
    t.integer  "count"
    t.string   "room"
    t.string   "shelf"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "barcode",    default: ""
    t.float    "value",      default: 0.0
  end

  create_table "unit_parts", force: :cascade do |t|
    t.integer  "part_id"
    t.integer  "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_id"], name: "index_unit_parts_on_part_id", using: :btree
    t.index ["unit_id"], name: "index_unit_parts_on_unit_id", using: :btree
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "type",            default: "User"
    t.uuid     "invite_token"
    t.uuid     "reset_token"
  end

  add_foreign_key "part_histories", "parts"
  add_foreign_key "part_histories", "users"
end
