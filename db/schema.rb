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

ActiveRecord::Schema.define(version: 20170718120927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "app_configs", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.integer "app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_app_configs_on_app_id"
  end

  create_table "apps", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.integer "server_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "scale", default: {}, null: false
    t.string "git_url"
    t.string "branches", array: true
    t.text "private_key"
    t.text "public_key"
    t.text "log"
    t.integer "status", default: 0
    t.index ["server_id"], name: "index_apps_on_server_id"
  end

  create_table "plugin_instances", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.integer "app_id"
    t.integer "server_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["app_id"], name: "index_plugin_instances_on_app_id"
    t.index ["server_id"], name: "index_plugin_instances_on_server_id"
  end

  create_table "server_commands", id: :serial, force: :cascade do |t|
    t.integer "server_id"
    t.string "command"
    t.string "token"
    t.datetime "ran_at"
    t.text "result"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "next_command_id"
    t.boolean "sync", default: false
    t.index ["next_command_id"], name: "index_server_commands_on_next_command_id"
    t.index ["server_id"], name: "index_server_commands_on_server_id"
  end

  create_table "server_logs", id: :serial, force: :cascade do |t|
    t.integer "server_id"
    t.string "action"
    t.text "details"
    t.string "status"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "timestamp"
    t.index ["server_id"], name: "index_server_logs_on_server_id"
    t.index ["user_id"], name: "index_server_logs_on_user_id"
  end

  create_table "servers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "addr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_synced_at"
    t.integer "user_id"
    t.string "endpoint"
    t.string "api_key"
    t.string "api_secret"
    t.json "plugins", default: {}
    t.integer "status", default: 0
    t.index ["user_id"], name: "index_servers_on_user_id"
  end

  create_table "ssh_keys", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "key"
    t.string "fingerprint"
    t.integer "server_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["server_id"], name: "index_ssh_keys_on_server_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "app_configs", "apps"
  add_foreign_key "apps", "servers"
  add_foreign_key "plugin_instances", "apps"
  add_foreign_key "plugin_instances", "servers"
  add_foreign_key "server_commands", "servers"
  add_foreign_key "server_logs", "servers"
  add_foreign_key "server_logs", "users"
  add_foreign_key "servers", "users"
  add_foreign_key "ssh_keys", "servers"
end
