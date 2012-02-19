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

ActiveRecord::Schema.define(:version => 20120218210603) do

  create_table "maps", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "description"
    t.integer  "year"
    t.integer  "min_zoom",         :default => 0
    t.integer  "max_zoom"
    t.integer  "init_zoom",        :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
    t.string   "map_file_name"
    t.string   "map_content_type"
    t.integer  "map_file_size"
    t.datetime "map_updated_at"
    t.boolean  "available"
  end

  add_index "maps", ["site_id"], :name => "index_maps_on_site_id"

  create_table "sites", :force => true do |t|
    t.string   "domain"
    t.string   "title"
    t.string   "short_desc"
    t.string   "long_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                             :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.string   "perishable_token",  :default => "", :null => false
    t.datetime "last_login_at"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
