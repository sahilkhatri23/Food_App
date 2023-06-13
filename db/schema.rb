# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_09_071659) do
  create_table "chats", force: :cascade do |t|
    t.string "message"
    t.integer "receiver_id"
    t.integer "sender_id"
    t.boolean "is_read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_chats_on_receiver_id"
    t.index ["sender_id"], name: "index_chats_on_sender_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "franchises", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "address"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_franchises_on_user_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.string "dish_name"
    t.integer "price"
    t.string "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "franchise_id"
    t.index ["franchise_id"], name: "index_menu_items_on_franchise_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "menu_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "order_time"
    t.integer "franchise_id"
    t.index ["franchise_id"], name: "index_orders_on_franchise_id"
    t.index ["menu_item_id"], name: "index_orders_on_menu_item_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "authentication_token", limit: 30
    t.integer "role", default: 0
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "franchises", "users"
  add_foreign_key "menu_items", "franchises"
  add_foreign_key "orders", "franchises"
end
