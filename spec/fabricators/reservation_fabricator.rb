# create_table "reservations", force: :cascade do |t|
#   t.date    "start_date"
#   t.date    "end_date"
#   t.integer "listing_id"
#   t.integer "user_id"
#   t.integer "status",     default: 0
#   t.index ["listing_id"], name: "index_reservations_on_listing_id", using: :btree
#   t.index ["user_id"], name: "index_reservations_on_user_id", using: :btree
# end

Fabricate.sequence(:start_date)
Fabricate.sequence(:end_date)
Fabricate.sequence(:listing)
Fabricate.sequence(:user)

Fabricator(:reservation) do
  start_date  {Date.today}
  end_date { Faker::Date.between(Date.today, Faker::Date.forward(Faker::Number.between(1, 30))) }
  listing { Fabricate(:listing) }
  user { Fabricate(:user) }
end
