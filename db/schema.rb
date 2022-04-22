ActiveRecord::Schema[7.0].define(version: 2022_04_20_075522) do
  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "date_event"
    t.time "duration_time"
    t.string "place"
    t.string "min_number_of_joiners"
    t.string "max_number_of_joiners"
    t.float "price"
    t.integer "min_age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "fullname"
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date_of_birth"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
