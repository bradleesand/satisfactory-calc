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

ActiveRecord::Schema.define(version: 2020_02_17_084929) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "machine_processes", force: :cascade do |t|
    t.bigint "recipe_id"
    t.integer "rate", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "machine_id"
    t.index ["machine_id"], name: "index_machine_processes_on_machine_id"
    t.index ["recipe_id"], name: "index_machine_processes_on_recipe_id"
  end

  create_table "machines", force: :cascade do |t|
    t.string "name"
    t.integer "input_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipe_inputs", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "resource_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipe_inputs_on_recipe_id"
    t.index ["resource_id"], name: "index_recipe_inputs_on_resource_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.bigint "output_id"
    t.integer "output_amount", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["output_id"], name: "index_recipes_on_output_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "machine_processes", "machines"
  add_foreign_key "machine_processes", "recipes"
  add_foreign_key "recipe_inputs", "recipes"
  add_foreign_key "recipe_inputs", "resources"
  add_foreign_key "recipes", "resources", column: "output_id"
end
