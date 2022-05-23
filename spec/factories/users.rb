FactoryBot.define do
  factory :user do
    fullname { "John" }
    username { "Rossi" }
    date_of_birth { Date.new(1991, 11, 26) }
    email { "john@john.com" }
    password { "123456" }
  end
end