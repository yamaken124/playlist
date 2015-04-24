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

ActiveRecord::Schema.define(version: 20150423110439) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255,              null: false
    t.date     "birth_date",                                      null: false
    t.integer  "bd_open",                limit: 4,   default: 0,  null: false
    t.integer  "gender",                 limit: 4,   default: 0,  null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "playlist_id", limit: 4
    t.text     "content",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "comments", ["playlist_id"], name: "index_comments_on_playlist_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "playlist_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "favorites", ["playlist_id"], name: "index_favorites_on_playlist_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "musics", force: :cascade do |t|
    t.integer  "playlist_id", limit: 4
    t.string   "url",         limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "title",       limit: 255
  end

  add_index "musics", ["playlist_id"], name: "index_musics_on_playlist_id", using: :btree

  create_table "playlists", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "title",      limit: 255
    t.string   "comment",    limit: 255
    t.integer  "genre",      limit: 4
    t.boolean  "fav",        limit: 1
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "count_fav",  limit: 4,   default: 0
  end

  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255,                null: false
    t.date     "birth_date",                                        null: false
    t.integer  "bd_open",                limit: 4,     default: 0,  null: false
    t.integer  "fav_music_genre",        limit: 4
    t.text     "comment",                limit: 65535
    t.integer  "gender",                 limit: 4,                  null: false
    t.string   "image",                  limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "comments", "playlists", on_delete: :cascade
  add_foreign_key "comments", "users", on_delete: :cascade
  add_foreign_key "favorites", "playlists", on_delete: :cascade
  add_foreign_key "musics", "playlists", on_delete: :cascade
  add_foreign_key "playlists", "users", on_delete: :cascade
end
