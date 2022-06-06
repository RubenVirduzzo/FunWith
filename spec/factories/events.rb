FactoryBot.define do
  factory :event do
    title { "event_first" } 
    description { "first" } 
    date_event { "2022-05-11" } 
    duration_time { "10:15:00.000" } 
    place { "La Malva-Rosa, Valencia, Spain" } 
    min_number_of_joiners { 1 } 
    max_number_of_joiners { 10 } 
    price { "5.0" } 
    min_age { "18" } 
    organizer_id {  } 
    tag_ids { [] } 
  end
end

