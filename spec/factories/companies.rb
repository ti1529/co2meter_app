FactoryBot.define do
  factory :company do
    name { "company_1" }
    contact_name { "user_1" }
    contact_email { "user_1@email.com" }
    status { 0 }
  end
end
