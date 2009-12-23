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

ActiveRecord::Schema.define(:version => 20091223190324) do

  create_table "achievements", :force => true do |t|
    t.integer  "type_id",     :default => 0
    t.integer  "user_id"
    t.string   "description"
    t.date     "from"
    t.date     "to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "geocodes", :force => true do |t|
    t.decimal "latitude",    :precision => 15, :scale => 12
    t.decimal "longitude",   :precision => 15, :scale => 12
    t.string  "query"
    t.string  "street"
    t.string  "locality"
    t.string  "region"
    t.string  "postal_code"
    t.string  "country"
    t.string  "precision"
  end

  add_index "geocodes", ["country"], :name => "geocodes_country_index"
  add_index "geocodes", ["latitude"], :name => "geocodes_latitude_index"
  add_index "geocodes", ["locality"], :name => "geocodes_locality_index"
  add_index "geocodes", ["longitude"], :name => "geocodes_longitude_index"
  add_index "geocodes", ["postal_code"], :name => "geocodes_postal_code_index"
  add_index "geocodes", ["precision"], :name => "geocodes_precision_index"
  add_index "geocodes", ["query"], :name => "geocodes_query_index", :unique => true
  add_index "geocodes", ["region"], :name => "geocodes_region_index"

  create_table "geocodings", :force => true do |t|
    t.integer "geocodable_id"
    t.integer "geocode_id"
    t.string  "geocodable_type"
  end

  add_index "geocodings", ["geocodable_id"], :name => "geocodings_geocodable_id_index"
  add_index "geocodings", ["geocodable_type"], :name => "geocodings_geocodable_type_index"
  add_index "geocodings", ["geocode_id"], :name => "geocodings_geocode_id_index"

  create_table "offers", :force => true do |t|
    t.integer  "type_id"
    t.string   "title"
    t.string   "permalink"
    t.integer  "user_id"
    t.integer  "place_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "end_at"
    t.integer  "etat",         :default => 0
    t.boolean  "zdalnie",      :default => false
    t.integer  "visits_count", :default => 0
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

  create_table "taggings", :force => true do |t|
    t.integer "tag_id"
    t.string  "taggable_type", :default => ""
    t.integer "taggable_id"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name", :default => ""
    t.string "kind", :default => ""
  end

  add_index "tags", ["name", "kind"], :name => "index_tags_on_name_and_kind"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count",                      :default => 0,     :null => false
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
    t.boolean  "osoba_prywatna",                   :default => false
    t.string   "goldenline"
    t.string   "profeo"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

  create_table "visits", :force => true do |t|
    t.integer  "offer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ip"
  end

end
