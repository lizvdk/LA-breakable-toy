require "factory_girl"

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

  factory :category do
    sequence(:name) { |n| "category#{n}" }
  end

  factory :report do
    sequence(:latitude) { |n| "42.3#{n}" } 
    sequence(:longitude) { |n| "71.05#{n}" }

    user
    category
  end
end
