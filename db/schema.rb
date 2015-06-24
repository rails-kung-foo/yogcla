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

ActiveRecord::Schema.define(version: 20150624205607) do

  create_table "admins", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.integer  "studio_id"
    t.integer  "style_id"
    t.string   "start"
    t.string   "ending"
    t.string   "weekday"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["studio_id"], name: "index_courses_on_studio_id"
  add_index "courses", ["style_id"], name: "index_courses_on_style_id"

  create_table "studios", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "styles", force: true do |t|
    t.text     "stil"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
