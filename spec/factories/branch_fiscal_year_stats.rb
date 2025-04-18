FactoryBot.define do
  factory :branch_fiscal_year_stat do
    fiscal_year { "2020" }
    annual_working_days { 240 }
    annual_employee_count { 20 }

    association :branch
    association :updater,
      factory: :user
  end

  factory :branch_fiscal_year_stat_2, class: BranchFiscalYearStat do
    fiscal_year { "2021" }
    annual_working_days { 245 }
    annual_employee_count { 22 }

    association :branch
    association :updater,
      factory: :user
  end

  factory :branch_fiscal_year_stat_3, class: BranchFiscalYearStat do
    fiscal_year { "2022" }
    annual_working_days { 250 }
    annual_employee_count { 24 }

    association :branch
    association :updater,
      factory: :user
  end

  factory :branch_fiscal_year_stat_n1, class: BranchFiscalYearStat do
    sequence(:fiscal_year) { |n| (2023+n).to_s }
    sequence(:annual_working_days) { |n| 219+n }
    sequence(:annual_employee_count) { |n| 19+n }

    association :branch
    association :updater,
      factory: :user
  end

  factory :branch_fiscal_year_stat_n2, class: BranchFiscalYearStat do
    sequence(:fiscal_year) { |n| (2023+n).to_s }
    sequence(:annual_working_days) { |n| 219+n }
    sequence(:annual_employee_count) { |n| 19+n }

    association :branch
    association :updater,
      factory: :user
  end
end
