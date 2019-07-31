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

ActiveRecord::Schema.define(version: 20190726160714) do

  create_table "scores", force: :cascade do |t|
    t.integer "balans", null: false
    t.string "objectable_type"
    t.integer "objectable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["objectable_type", "objectable_id"], name: "index_scores_on_objectable_type_and_objectable_id"
  end

  create_table "teem_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "teem_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teems", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "score_id", null: false
    t.string "name", default: "", null: false
    t.string "type", default: "", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
