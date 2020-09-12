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

ActiveRecord::Schema.define(version: 2020_09_12_094409) do

  create_table "composers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "first_name", limit: 25
    t.string "last_name", limit: 25
    t.string "middle_name", limit: 25
    t.integer "birth_year"
    t.integer "death_year"
    t.string "country", limit: 3
  end

  create_table "customers", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "first_name", limit: 30
    t.string "last_name", limit: 30
    t.string "nick", limit: 15
    t.string "password", limit: 40
    t.string "email", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "editions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "work_id", null: false
    t.string "description", limit: 30
    t.integer "year"
    t.float "price"
    t.bigint "publisher_id"
    t.string "title", limit: 100
    t.index ["publisher_id"], name: "index_editions_on_publisher_id"
  end

  create_table "editions_works", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "edition_id"
    t.bigint "work_id"
    t.index ["edition_id"], name: "index_editions_works_on_edition_id"
    t.index ["work_id"], name: "index_editions_works_on_work_id"
  end

  create_table "instruments", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", limit: 20
    t.string "family", limit: 15
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "instruments_works", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "instrument_id"
    t.bigint "work_id"
    t.index ["instrument_id"], name: "index_instruments_works_on_instrument_id"
    t.index ["work_id"], name: "index_instruments_works_on_work_id"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "status"
    t.integer "edition_id"
    t.bigint "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "publishers", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", limit: 60
    t.string "city", limit: 30
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price"
  end

  create_table "works", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "composer_id"
    t.string "title", limit: 100
    t.integer "year"
    t.string "key"
    t.integer "opus"
  end

  add_foreign_key "editions", "publishers"
  add_foreign_key "orders", "customers"
end
