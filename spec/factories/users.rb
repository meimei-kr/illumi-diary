FactoryBot.define do
  factory :user do
    name { |n| "name_#{n}" }
    sequence(:email) { |n| "email_#{n}@example" }
    password { 'password' }
    password_confirmation { 'password' }
    is_member { true }

    trait :guest do
      name { |n| "guest_#{n}" }
      sequence(:email) { |n| "guest_#{n}@example" }
      is_member { false }
    end
  end
end