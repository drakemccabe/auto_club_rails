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

ActiveRecord::Schema.define(version: 20160109023306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: :cascade do |t|
    t.integer  "driver_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendees", ["driver_id"], name: "index_attendees_on_driver_id", using: :btree
  add_index "attendees", ["event_id"], name: "index_attendees_on_event_id", using: :btree

  create_table "drivers", force: :cascade do |t|
    t.string   "car",        null: false
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "email"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",         null: false
    t.date     "date",         null: false
    t.integer  "price",        null: false
    t.string   "location",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_url"
    t.string   "photo_url"
  end

  add_index "events", ["date"], name: "index_events_on_date", unique: true, using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer "correlation_id", null: false
    t.integer "event1"
    t.integer "event2"
    t.integer "price",          null: false
    t.string  "first_name"
    t.string  "last_name"
    t.string  "car"
    t.string  "note"
    t.string  "item_name"
    t.string  "email"
    t.boolean "payment_status", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
