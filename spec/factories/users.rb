# FactoryBot.define do
#   factory :user do
#     first_name { "MyString" }
#     last_name { "MyString" }
#     email { "MyString" }
#     phone { "MyString" }
#     role { 1 }
#   end
# end
FactoryBot.define do 
  factory :user do
    first_name {Faker::Name.first_name}
    last_name  {Faker::Name.last_name}
    email      {Faker::Internet.email}
    phone      {Faker::PhoneNumber.phone_number_with_country_code}
    role       {Faker::Types.rb_integer(from: 0, to: 2)}
  end 
end