FactoryBot.define do
  factory :user do
    name { "user_1" }
    sequence(:email) { |n| "user_#{n}@email.com" }
    password { "password65432123" }
    password_confirmation { "password65432123" }
    admin { false }

    association :company
  end

  factory :admin, class: User do
    name { "admin_1" }
    email { "admin_1@email.com" }
    password { "password65432123" }
    password_confirmation { "password65432123" }
    admin { true }

    association :company
  end
end
