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

ActiveRecord::Schema.define(version: 20140419215128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "level_pages", force: true do |t|
    t.integer  "level_id"
    t.integer  "page_number"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "level_schemas", force: true do |t|
    t.integer  "level_id"
    t.string   "table_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "level_tests", force: true do |t|
    t.integer  "level_id"
    t.text     "test_query"
    t.text     "expected_output"
    t.string   "error_message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
    t.string   "title"
    t.text     "prompt"
    t.integer  "stage_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "database_path"
    t.text     "dump"
    t.text     "answer"
    t.string   "level_type"
    t.text     "default_text"
  end

  create_table "schema_columns", force: true do |t|
    t.integer  "level_schema_id"
    t.string   "column_name"
    t.string   "column_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_databases", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level_id"
  end

  create_table "user_levels", force: true do |t|
    t.integer  "user_id"
    t.integer  "level_id"
    t.boolean  "completed",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "guest",           default: false
    t.datetime "last_logged_in"
  end

end
