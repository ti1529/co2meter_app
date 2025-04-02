FactoryBot.define do
  factory :co2_emission_factor do
    fiscal_year { "2020" }
    workplace_type { 0 }
    city_category { 0 }
    co2_emission_factor { 2 }
    co2_emission_factor_unit { "kgCO2/人・日" }
  end
end
