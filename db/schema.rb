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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130613204457) do

  create_table "hotspots", :force => true do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "zip"
    t.string   "phone"
    t.string   "fee"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "hotspot_id"
    t.integer  "user_id"
    t.integer  "speed"
    t.integer  "reliability"
    t.integer  "accessibility"
    t.integer  "power"
    t.integer  "noise_level"
    t.text     "comments"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "location"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.boolean  "admin"
  end

end
