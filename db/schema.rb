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

ActiveRecord::Schema[7.0].define(version: 2023_10_16_033644) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "claps", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "diary_id", null: false
    t.integer "count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_claps_on_diary_id"
    t.index ["user_id"], name: "index_claps_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.bigint "diary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diary_id"], name: "index_comments_on_diary_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "diaries", force: :cascade do |t|
    t.text "content1", null: false
    t.text "content2", null: false
    t.text "content3", null: false
    t.bigint "user_id", null: false
    t.boolean "allow_publication", default: false, null: false
    t.boolean "allow_comments", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "comments_count", default: 0, null: false
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "avatar_image"
    t.string "character_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.boolean "is_member", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "claps", "diaries"
  add_foreign_key "claps", "users"
  add_foreign_key "comments", "diaries"
  add_foreign_key "comments", "users"
  add_foreign_key "diaries", "users"
end
