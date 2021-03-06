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

ActiveRecord::Schema.define(version: 20180401002346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "available_forms", force: :cascade do |t|
    t.bigint "document_id"
    t.string "table_name"
    t.jsonb "fields"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_available_forms_on_document_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.text "contents"
    t.bigint "site_id"
    t.bigint "user_id"
    t.bigint "folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["folder_id"], name: "index_documents_on_folder_id"
    t.index ["site_id"], name: "index_documents_on_site_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "folders", force: :cascade do |t|
    t.bigint "site_id"
    t.bigint "folder_id"
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["folder_id"], name: "index_folders_on_folder_id"
    t.index ["site_id"], name: "index_folders_on_site_id"
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "kql_data_stores", force: :cascade do |t|
    t.jsonb "structure", default: {}
    t.bigint "user_id"
    t.string "name"
    t.jsonb "values", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_kql_data_stores_on_user_id"
  end

  create_table "objekts", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.text "contents"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_objekt_id"
    t.bigint "user_id"
    t.string "path"
    t.index ["user_id"], name: "index_objekts_on_user_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.bigint "user_id"
    t.text "contents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sites_on_user_id"
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "available_forms", "documents"
  add_foreign_key "documents", "folders"
  add_foreign_key "documents", "sites"
  add_foreign_key "documents", "users"
  add_foreign_key "folders", "folders"
  add_foreign_key "folders", "sites"
  add_foreign_key "folders", "users"
  add_foreign_key "kql_data_stores", "users"
  add_foreign_key "objekts", "users"
  add_foreign_key "sites", "users"
end
