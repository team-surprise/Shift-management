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

ActiveRecord::Schema[7.2].define(version: 2025_08_31_040338) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employments", force: :cascade do |t|
    t.bigint "store_id", null: false
    t.bigint "user_id", null: false
    t.integer "status"
    t.date "start_date"
    t.date "end_date"
    t.integer "hourly_wage_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_employments_on_store_id"
    t.index ["user_id"], name: "index_employments_on_user_id"
  end

  create_table "shift_requests", force: :cascade do |t|
    t.bigint "store_id", null: false
    t.bigint "user_id", null: false
    t.datetime "requested_date_user"
    t.datetime "requested_date_store"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id", "user_id"], name: "index_shift_requests_on_store_id_and_user_id"
    t.index ["store_id"], name: "index_shift_requests_on_store_id"
    t.index ["user_id"], name: "index_shift_requests_on_user_id"
  end

  create_table "store_accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_store_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_store_accounts_on_reset_password_token", unique: true
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "phone_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_stores_on_name", unique: true
  end

  create_table "time_records", force: :cascade do |t|
    t.bigint "work_day_id", null: false
    t.datetime "clock_in_time", null: false
    t.datetime "clock_out_time"
    t.integer "break_time", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_day_id"], name: "index_time_records_on_work_day_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name", default: "", null: false
    t.string "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_days", force: :cascade do |t|
    t.bigint "store_id", null: false
    t.bigint "user_id", null: false
    t.date "work_date", null: false
    t.integer "work_hours", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id", "user_id", "work_date"], name: "index_work_days_on_store_id_and_user_id_and_work_date", unique: true
    t.index ["store_id"], name: "index_work_days_on_store_id"
    t.index ["user_id"], name: "index_work_days_on_user_id"
  end

  add_foreign_key "employments", "stores"
  add_foreign_key "employments", "users"
  add_foreign_key "shift_requests", "stores"
  add_foreign_key "shift_requests", "users"
  add_foreign_key "time_records", "work_days"
  add_foreign_key "work_days", "stores"
  add_foreign_key "work_days", "users"
end
