FactoryGirl.define do
  factory :consumer do
    name { Faker::Company.name }
    project
  end
end
