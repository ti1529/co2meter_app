FactoryBot.define do
  factory :co2_emission_factor do
    fiscal_year { "2020" }
    workplace_type { 0 }
    sequence(city_category) { |n| (n-1)%5 }
    sequence (:co2_emission_factor) { |n| n }
    co2_emission_factor_unit { "kgCO2/人・日" }
  end

  factory :co2_emission_factor_office, class: Co2EmissionFactor  do
    fiscal_year { "2020" }
    workplace_type { 0 }
    sequence(:city_category) { |n| (n-1)%5 }
    sequence (:co2_emission_factor) { |n| n }
    co2_emission_factor_unit { "kgCO2/人・日" }
  end

  factory :co2_emission_factor_factory, class: Co2EmissionFactor  do
    fiscal_year { "2020" }
    workplace_type { 1 }
    sequence(:city_category) { |n| (n-1)%5 }
    sequence (:co2_emission_factor) { |n| n }
    co2_emission_factor_unit { "kgCO2/人・日" }
  end
end
