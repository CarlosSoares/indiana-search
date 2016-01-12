FactoryGirl.define do

  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password "user123456"
    password_confirmation "user123456"
    company
  end

end
