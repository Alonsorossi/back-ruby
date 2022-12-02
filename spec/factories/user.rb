FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.safe_email }
    dni { '31456731A' }
    password { '12345' }
  end
end
