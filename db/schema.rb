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

ActiveRecord::Schema.define(:version => 20121024062400) do

  create_table "application_details", :force => true do |t|
    t.string   "application_id"
    t.string   "region_code"
    t.text     "summary"
    t.text     "icon_url"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "applications", :id => false, :force => true do |t|
    t.string   "id",         :null => false
    t.string   "bundle_id"
    t.boolean  "iphone"
    t.boolean  "ipad"
    t.string   "artist_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "artists", :id => false, :force => true do |t|
    t.string   "id",         :null => false
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :id => false, :force => true do |t|
    t.string   "id",         :null => false
    t.string   "label"
    t.string   "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "level"
  end

  create_table "regions", :id => false, :force => true do |t|
    t.string   "code",       :limit => 2,                    :null => false
    t.string   "name_en"
    t.string   "name_ja"
    t.boolean  "enabled",                 :default => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

end
