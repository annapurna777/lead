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

ActiveRecord::Schema.define(version: 2019_08_05_110458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.integer "mobile_number"
    t.string "email"
    t.string "password_digest"
    t.string "user_name"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "otp"
    t.boolean "everified"
    t.boolean "pverified"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "country_code"
  end

  create_table "leaders", force: :cascade do |t|
    t.string "name"
    t.string "docf"
    t.string "docb"
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lead_type"
    t.integer "account_number"
    t.integer "made_by"
    t.text "made_at"
    t.index ["admin_id"], name: "index_leaders_on_admin_id"
  end

  create_table "nominees", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.bigint "leader_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["leader_id"], name: "index_nominees_on_leader_id"
  end

  add_foreign_key "leaders", "admins"
  add_foreign_key "nominees", "leaders"
end
