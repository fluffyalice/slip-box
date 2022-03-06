# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_23_150925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branch_links", force: :cascade do |t|
    t.integer "note_id"
    t.integer "link_to"
    t.index ["link_to"], name: "index_branch_links_on_link_to"
    t.index ["note_id"], name: "index_branch_links_on_note_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title", null: false
    t.text "content", null: false
    t.integer "thread_id", null: false
    t.integer "position", null: false
    t.datetime "last_edit", null: false
    t.bigint "reference_id"
    t.bigint "type_id"
    t.index ["reference_id"], name: "index_notes_on_reference_id"
    t.index ["type_id"], name: "index_notes_on_type_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "notes_tags", id: false, force: :cascade do |t|
    t.bigint "note_id"
    t.bigint "tag_id"
    t.index ["note_id"], name: "index_notes_tags_on_note_id"
    t.index ["tag_id"], name: "index_notes_tags_on_tag_id"
  end

  create_table "references", force: :cascade do |t|
    t.bigint "user_id"
    t.string "author", null: false
    t.string "title", null: false
    t.integer "year"
    t.string "url"
    t.text "info"
    t.index ["user_id"], name: "index_references_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "tags", force: :cascade do |t|
    t.bigint "user_id"
    t.string "tag_name", null: false
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "types", force: :cascade do |t|
    t.bigint "user_id"
    t.string "type_name", null: false
    t.string "colour_code", null: false
    t.index ["user_id"], name: "index_types_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "uid"
    t.string "mail"
    t.string "ou"
    t.string "dn"
    t.string "sn"
    t.string "givenname"
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username"
  end

end
