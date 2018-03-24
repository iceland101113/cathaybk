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

ActiveRecord::Schema.define(version: 20180324015856) do

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "basics", force: :cascade do |t|
    t.string "age"
    t.string "education"
    t.string "marriage"
    t.string "house"
    t.string "job"
    t.string "job_title"
    t.string "longevity"
    t.string "income"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.integer "partA", default: 0, null: false
    t.integer "partB", default: 0, null: false
    t.integer "partC", default: 0, null: false
    t.integer "partD", default: 0, null: false
    t.integer "partE", default: 0, null: false
    t.integer "partF", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credits", force: :cascade do |t|
    t.string "credit_num"
    t.string "credit_time"
    t.string "credit_money"
    t.string "credit_all_money"
    t.string "credit_last"
    t.string "credit_new"
    t.string "credit_current_money"
    t.string "credit_current_all_money"
    t.string "repay_month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.string "phone_number"
    t.string "pin"
    t.boolean "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.string "queue"
    t.string "time"
    t.integer "user_id"
    t.integer "bank_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_id"], name: "index_reservations_on_bank_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "selects", force: :cascade do |t|
    t.integer "basic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "gender"
    t.string "phone"
    t.string "mail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
