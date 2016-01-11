FactoryGirl.define do

  factory :project do
    name {Faker::Name.name}
    company
  end

end
