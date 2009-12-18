# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091218224359) do

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", :force => true do |t|
    t.integer  "type_id"
    t.string   "title"
    t.string   "permalink"
    t.integer  "user_id"
    t.integer  "place_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "etat",        :default => false
  end

  create_table "places", :force => true do |t|
    t.integer "province_id"
    t.string  "gender_code", :limit => 2
    t.string  "name",        :limit => 128
  end

  add_index "places", ["name", "gender_code"], :name => "index_places_on_name_and_gender_code"
  add_index "places", ["name"], :name => "index_places_on_name"
  add_index "places", ["province_id", "name", "gender_code"], :name => "index_places_on_province_id_and_name_and_gender_code"
  add_index "places", ["province_id", "name"], :name => "index_places_on_province_id_and_name"
  add_index "places", ["province_id"], :name => "index_places_on_province_id"

  create_table "provinces", :force => true do |t|
    t.string "name", :limit => 32
    t.string "code", :limit => 2
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tools", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count",                      :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sex",                              :default => 0
    t.date     "birthdate"
    t.string   "website"
    t.string   "phone"
    t.string   "company"
    t.integer  "place_id"
    t.integer  "type_id",                          :default => 0
    t.string   "permalink"
    t.integer  "facebook_uid",        :limit => 8
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "github"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
