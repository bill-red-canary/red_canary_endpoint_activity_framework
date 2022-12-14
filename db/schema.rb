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

ActiveRecord::Schema[7.0].define(version: 2022_11_04_203008) do
  create_table "endpoint_processes", force: :cascade do |t|
    t.text "command"
    t.string "name"
    t.integer "process_id"
    t.datetime "start_time"
    t.string "user_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "file_activities", force: :cascade do |t|
    t.string "file_path"
    t.integer "activity"
    t.integer "endpoint_process_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["endpoint_process_id"], name: "index_file_activities_on_endpoint_process_id"
  end

  create_table "network_activities", force: :cascade do |t|
    t.text "data"
    t.string "data_protocol"
    t.integer "data_size"
    t.string "destination_address"
    t.integer "destination_port"
    t.integer "endpoint_process_id", null: false
    t.string "url", null: false
    t.string "source_address"
    t.integer "source_port"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["endpoint_process_id"], name: "index_network_activities_on_endpoint_process_id"
  end

  add_foreign_key "file_activities", "endpoint_processes"
  add_foreign_key "network_activities", "endpoint_processes"
end
