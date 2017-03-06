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

ActiveRecord::Schema.define(version: 20170305151530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bill_of_materials", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "issue_type_id"
    t.index ["issue_type_id"], name: "index_bill_of_materials_on_issue_type_id", using: :btree
  end

  create_table "bill_of_materials_item_types", id: false, force: :cascade do |t|
    t.integer "bill_of_material_id"
    t.integer "item_type_id"
    t.integer "item_type_count"
  end

  create_table "component_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "component_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "component_category_id"
    t.index ["component_category_id"], name: "index_component_types_on_component_category_id", using: :btree
  end

  create_table "components", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "equipment_id"
    t.string   "beacon_uuid"
    t.float    "beacon_latitude"
    t.float    "beacon_longitude"
    t.integer  "component_type_id"
    t.index ["component_type_id"], name: "index_components_on_component_type_id", using: :btree
    t.index ["equipment_id"], name: "index_components_on_equipment_id", using: :btree
  end

  create_table "equipment", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "beacon_uuid"
    t.float    "beacon_latitude"
    t.float    "beacon_longitude"
    t.integer  "equipment_type_id"
    t.string   "name"
    t.index ["equipment_type_id"], name: "index_equipment_on_equipment_type_id", using: :btree
  end

  create_table "equipment_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.string   "tag"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "issue_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "priority"
    t.integer  "component_type_id"
    t.index ["component_type_id"], name: "index_issue_types_on_component_type_id", using: :btree
  end

  create_table "issues", force: :cascade do |t|
    t.integer  "status"
    t.text     "comment"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "issue_type_id"
    t.integer  "component_id"
    t.integer  "priority"
    t.datetime "finished_at"
    t.integer  "work_report_id"
    t.datetime "scheduled_start_date"
    t.datetime "scheduled_finished_date"
    t.datetime "started_at"
    t.integer  "estimated_hours"
    t.integer  "actual_hours"
    t.boolean  "was_planned_maintenance"
    t.boolean  "requires_shutdown_of_equipment"
    t.integer  "activity_type"
    t.integer  "total_cost"
    t.index ["component_id"], name: "index_issues_on_component_id", using: :btree
    t.index ["issue_type_id"], name: "index_issues_on_issue_type_id", using: :btree
  end

  create_table "item_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "order_id"
    t.integer  "items_count", default: 0
    t.index ["order_id"], name: "index_item_types_on_order_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.boolean  "is_reserved"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "item_type_id"
    t.index ["item_type_id"], name: "index_items_on_item_type_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "item_count"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "item_type_id"
    t.datetime "expected_arrival_time"
    t.datetime "arrived_at"
    t.index ["item_type_id"], name: "index_orders_on_item_type_id", using: :btree
  end

  add_foreign_key "bill_of_materials", "issue_types"
  add_foreign_key "component_types", "component_categories"
  add_foreign_key "components", "component_types"
  add_foreign_key "components", "equipment"
  add_foreign_key "equipment", "equipment_types"
  add_foreign_key "issue_types", "component_types"
  add_foreign_key "issues", "components"
  add_foreign_key "issues", "issue_types"
  add_foreign_key "item_types", "orders"
  add_foreign_key "items", "item_types"
  add_foreign_key "orders", "item_types"
end
