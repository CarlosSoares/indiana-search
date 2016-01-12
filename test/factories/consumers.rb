FactoryGirl.define do
  factory :consumer do
    name { Faker::Name.name }
    project_id { Faker::Number.number(1) }
    token { Faker::Internet.password }
  end

end
