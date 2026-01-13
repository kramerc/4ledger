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

ActiveRecord::Schema[8.1].define(version: 2026_01_13_073016) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "currency", default: "USD"
    t.integer "kind"
    t.string "name"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "simplefin_accounts", force: :cascade do |t|
    t.bigint "account_id"
    t.string "available_balance"
    t.string "balance"
    t.datetime "balance_date", precision: nil
    t.datetime "created_at", null: false
    t.string "currency"
    t.jsonb "extra"
    t.string "name"
    t.jsonb "org"
    t.string "remote_id"
    t.bigint "simplefin_connection_id", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_simplefin_accounts_on_account_id", unique: true
    t.index ["simplefin_connection_id"], name: "index_simplefin_accounts_on_simplefin_connection_id"
  end

  create_table "simplefin_connections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "refreshed_at", precision: nil
    t.datetime "updated_at", null: false
    t.string "url"
    t.bigint "user_id", null: false
    t.index ["refreshed_at"], name: "index_simplefin_connections_on_refreshed_at"
    t.index ["user_id"], name: "index_simplefin_connections_on_user_id", unique: true
  end

  create_table "simplefin_transactions", force: :cascade do |t|
    t.string "amount"
    t.datetime "created_at", null: false
    t.string "description"
    t.jsonb "extra"
    t.boolean "pending"
    t.datetime "posted", precision: nil
    t.string "remote_id"
    t.bigint "simplefin_account_id", null: false
    t.datetime "transacted_at", precision: nil
    t.datetime "updated_at", null: false
    t.index ["simplefin_account_id"], name: "index_simplefin_transactions_on_simplefin_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "simplefin_accounts", "accounts"
  add_foreign_key "simplefin_accounts", "simplefin_connections"
  add_foreign_key "simplefin_connections", "users"
  add_foreign_key "simplefin_transactions", "simplefin_accounts"
end
