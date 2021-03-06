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

ActiveRecord::Schema.define(:version => 20090922081059) do

  create_table "pings", :force => true do |t|
    t.datetime "when_timestamp"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.text     "message"
    t.integer  "trip_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travellers", :force => true do |t|
    t.string   "login"
    t.string   "name"
    t.string   "email"
    t.string   "homepage"
    t.text     "bio"
    t.string   "pop_host"
    t.string   "pop_login"
    t.string   "pop_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travellers_trips", :id => false, :force => true do |t|
    t.integer "traveller_id"
    t.integer "trip_id"
  end

  create_table "trips", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "destination_latitude"
    t.decimal  "destination_longitude"
  end

end
