FactoryBot.define do
  factory :event do
    name { "My Fantastic Conference" }
    cfp_open_until { Time.now.utc + 1.hour }
    date_of_event { Time.now.utc + 1.week }
    available_slots { 5 }
    user
  end
end
