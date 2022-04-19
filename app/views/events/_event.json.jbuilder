
json.extract! event, :id, :title, :description, :date_event, :duration_time, :place, :min_number_of_joiners, :max_number_of_joiners, :price, :min_age, :created_at, :updated_at

json.url event_url(event, format: :json)
