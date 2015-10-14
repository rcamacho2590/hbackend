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

ActiveRecord::Schema.define(version: 20151014034908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_relationships", ["followed_id"], name: "index_active_relationships_on_followed_id", using: :btree
  add_index "active_relationships", ["follower_id", "followed_id"], name: "index_active_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "active_relationships", ["follower_id"], name: "index_active_relationships_on_follower_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "post_id",     null: false
    t.integer  "user_id",     null: false
    t.string   "description", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", force: true do |t|
    t.integer  "post_id",                     null: false
    t.integer  "user_id",                     null: false
    t.string   "description"
    t.integer  "comment_id"
    t.integer  "like_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "read",        default: false
  end

  create_table "likes", force: true do |t|
    t.integer  "post_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_types", force: true do |t|
    t.string   "description", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "description"
    t.integer  "user_id"
    t.string   "location"
    t.integer  "post_type_id"
    t.integer  "views_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
    t.integer  "comments_count", default: 0
    t.integer  "likes_count",    default: 0
  end

  create_table "users", force: true do |t|
    t.string   "username",                           null: false
    t.string   "full_name",                          null: false
    t.string   "email",                              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",                 null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "authentication_token",               null: false
    t.string   "reset_password_code"
    t.string   "avatar"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "views", force: true do |t|
    t.integer  "post_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
