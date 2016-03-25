FactoryGirl.define do
  factory :search do
    query { Faker::Company.name }
    table_name { %w(clients users).sample }
    field { %w(user id).sample }
    consumer
  end
end
