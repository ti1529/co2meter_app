FactoryBot.define do
  factory :user do
    name { "user_1" }
    email { "user_1@email.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { false }

    association :company
  end

  factory :admin, class: User do
    name { "admin_1" }
    email { "admin_1@email.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { true }

    association :company
  end
end
