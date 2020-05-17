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

ActiveRecord::Schema.define(version: 2020_05_16_190133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: :cascade do |t|
    t.string "g_id"
    t.string "summary"
    t.string "timezone"
    t.string "fg_color"
    t.string "bg_color"
    t.string "g_next_sync_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["g_id", "user_id"], name: "index_calendars_on_g_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_calendars_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "g_id"
    t.string "summary"
    t.string "description"
    t.string "status"
    t.string "html_link"
    t.jsonb "start_time", default: {}
    t.jsonb "end_time", default: {}
    t.string "location"
    t.jsonb "creator", default: {}
    t.jsonb "organizer", default: {}
    t.bigint "calendar_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id"], name: "index_events_on_calendar_id"
    t.index ["g_id", "calendar_id"], name: "index_events_on_g_id_and_calendar_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "image_url"
    t.string "g_next_sync_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "google_token"
    t.string "google_refresh_token"
    t.string "token_provider"
    t.integer "google_token_expires_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "calendars", "users"
  add_foreign_key "events", "calendars"
end
