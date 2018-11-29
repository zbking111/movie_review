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

ActiveRecord::Schema.define(version: 2018_11_29_143144) do

  create_table "actors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.string "role"
  end

  create_table "cats", force: :cascade do |t|
    t.string "name"
  end

  create_table "list_films", force: :cascade do |t|
    t.integer "user_id"
    t.integer "movie_id"
    t.integer "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "list_id"
    t.integer "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movie_characters", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "actor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.string "picture"
    t.string "info"
    t.integer "check"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "rate_score"
    t.date "date"
    t.string "category"
    t.string "nation"
    t.integer "duration"
    t.string "trailer"
  end

  create_table "nations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notis", force: :cascade do |t|
    t.integer "user_id"
    t.string "content"
    t.string "picture"
    t.integer "seen"
    t.integer "sub_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rates", force: :cascade do |t|
    t.integer "user_id"
    t.integer "movie_id"
    t.integer "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "review_actions", force: :cascade do |t|
    t.integer "review_id"
    t.integer "user_id"
    t.integer "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "movie_id"
    t.string "content"
    t.integer "review_voteup"
    t.integer "review_votedown"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

# Could not dump table "users" because of following StandardError
#   Unknown type 'bool' for column 'deactivated'

end
