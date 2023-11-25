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

ActiveRecord::Schema[7.1].define(version: 2023_11_25_013731) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "devices", force: :cascade do |t|
    t.string "orientation"
    t.string "quantity"
    t.string "char_id"
    t.integer "validation_run_id", null: false
    t.index ["validation_run_id"], name: "index_devices_on_validation_run_id"
  end

  create_table "heads", force: :cascade do |t|
    t.string "chid"
    t.string "title"
    t.integer "validation_run_id", null: false
    t.index ["validation_run_id"], name: "index_heads_on_validation_run_id"
  end

  create_table "miscs", force: :cascade do |t|
    t.decimal "gvec_x"
    t.decimal "gvec_y"
    t.decimal "gvec_z"
    t.integer "validation_run_id", null: false
    t.index ["validation_run_id"], name: "index_miscs_on_validation_run_id"
  end

  create_table "slice_files", force: :cascade do |t|
    t.integer "validation_run_id", null: false
    t.string "quantity"
    t.boolean "vector", default: false
    t.decimal "pbx"
    t.decimal "pby"
    t.decimal "pbz"
    t.string "char_id"
    t.index ["validation_run_id"], name: "index_slice_files_on_validation_run_id"
  end

  create_table "surfaces", force: :cascade do |t|
    t.string "char_id"
    t.decimal "volume_flow"
    t.integer "validation_run_id"
    t.index ["char_id", "validation_run_id"], name: "index_surfaces_on_char_id_and_validation_run_id", unique: true
    t.index ["validation_run_id"], name: "index_surfaces_on_validation_run_id"
  end

  create_table "unmapped_name_lists", force: :cascade do |t|
    t.string "line"
    t.integer "validation_run_id", null: false
    t.index ["validation_run_id"], name: "index_unmapped_name_lists_on_validation_run_id"
  end

  create_table "validation_runs", force: :cascade do |t|
    t.string "run_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vents", force: :cascade do |t|
    t.string "surface_id"
    t.integer "validation_run_id"
    t.index ["surface_id"], name: "index_vents_on_surface_id"
    t.index ["validation_run_id"], name: "index_vents_on_validation_run_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "devices", "validation_runs"
  add_foreign_key "heads", "validation_runs"
  add_foreign_key "miscs", "validation_runs"
  add_foreign_key "slice_files", "validation_runs"
  add_foreign_key "unmapped_name_lists", "validation_runs"
end
