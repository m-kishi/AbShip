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

ActiveRecord::Schema.define(version: 20150601000000) do

  create_table "balances", force: :cascade do |t|
    t.integer "year"
    t.integer "earn"
    t.integer "bnus"
    t.integer "expense"
    t.integer "special"
    t.integer "balance"
  end

  create_table "expenses", force: :cascade do |t|
    t.date    "date"
    t.string  "name"
    t.string  "type"
    t.integer "cost"
  end

  create_table "graphics", force: :cascade do |t|
    t.integer "year"
    t.integer "mnth"
    t.integer "food"
    t.integer "otfd"
    t.integer "engy_elc"
    t.integer "engy_gas"
    t.integer "engy_wtr"
  end

  create_table "privates", force: :cascade do |t|
    t.string  "date"
    t.string  "name"
    t.integer "cost"
    t.integer "blnc"
  end

  create_table "summaries", force: :cascade do |t|
    t.integer "year"
    t.integer "mnth"
    t.integer "food"
    t.integer "otfd"
    t.integer "good"
    t.integer "frnd"
    t.integer "trfc"
    t.integer "play"
    t.integer "hous"
    t.integer "engy"
    t.integer "cnct"
    t.integer "medi"
    t.integer "insu"
    t.integer "othr"
    t.integer "earn"
    t.integer "bnus"
    t.integer "spcl"
    t.integer "prvi"
    t.integer "prvo"
    t.integer "ttal"
    t.integer "blnc"
  end

  create_table "users", force: :cascade do |t|
    t.string   "mail",             null: false
    t.string   "salt"
    t.string   "crypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["mail"], name: "index_users_on_mail", unique: true

end
