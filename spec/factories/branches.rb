FactoryBot.define do
  factory :branch do
    name { "支店_1" }
    workplace_type { 0 }
    city_category { 0 }
    postcode { "1234567" }
    prefecture { "千葉県" }
    city { "千葉市" }
    address_line1 { "123" }
    address_line2 { "ビル_1" }

    association :company
  end

  factory :branch_2, class: Branch do
    name { "支店_2" }
    workplace_type { 1 }
    city_category { 1 }
    postcode { "1234567" }
    prefecture { "茨木県" }
    city { "水戸市" }
    address_line1 { "123" }
    address_line2 { "ビル_1" }

    association :company
  end
end
