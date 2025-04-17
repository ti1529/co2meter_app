FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "会社_#{n}" }
    contact_name { "user_1" }
    contact_email { "user_1@email.com" }
    status { 0 }
  end
end
