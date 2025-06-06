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

ActiveRecord::Schema[7.2].define(version: 2025_05_20_174840) do
  create_table "repositories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.string "full_name"
    t.string "language"
    t.integer "github_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "clone_path"
    t.string "web_path"
    t.string "commits_path"
    t.string "hooks_path"
    t.index ["github_id"], name: "index_repositories_on_github_id", unique: true
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "repository_checks", force: :cascade do |t|
    t.integer "repository_id", null: false
    t.text "aasm_state", default: "created", null: false
    t.boolean "passed"
    t.text "commit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "clone_path"
    t.text "result"
    t.string "error"
    t.index ["repository_id"], name: "index_repository_checks_on_repository_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "nickname"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "repositories", "users"
  add_foreign_key "repository_checks", "repositories"
end
