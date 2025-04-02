FactoryBot.define do
  factory :branch_fiscal_year_stat do
    fiscal_year { "2020" }
    annual_working_days { 240 }
    annual_employee_count { 20 }

    association :branch
    association :updater,
      factory: :user
  end
end
