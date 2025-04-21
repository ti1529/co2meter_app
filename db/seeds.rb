# アプリ提供側の初期データ
company = Company.find_or_create_by(
  name: "アプリ提供会社",
  contact_name: "管理者",
  contact_email: "admin@email.com",
  status: 0,
)
unless User.find_by(email: "admin@email.com")
  company.users.create!(
  name: "管理者",
  email: "admin@email.com",
  password: "password",
  password_confirmation: "password",
  admin: true
  )
end


10.times do |i|
  [
    [ (2020 + i).to_s, 0, 0, 0.985, "kgCO2/人・日" ],
    [ (2020 + i).to_s, 0, 1, 1.54, "kgCO2/人・日" ],
    [ (2020 + i).to_s, 0, 2, 1.84, "kgCO2/人・日" ],
    [ (2020 + i).to_s, 0, 3, 1.59, "kgCO2/人・日" ],
    [ (2020 + i).to_s, 0, 4, 1.57, "kgCO2/人・日" ],

    [ (2020 + i).to_s, 1, 0, 1.22, "kgCO2/人・日" ],
    [ (2020 + i).to_s, 1, 1, 1.89, "kgCO2/人・日" ],
    [ (2020 + i).to_s, 1, 2, 1.92, "kgCO2/人・日" ],
    [ (2020 + i).to_s, 1, 3, 1.81, "kgCO2/人・日" ],
    [ (2020 + i).to_s, 1, 4, 1.84, "kgCO2/人・日" ]
  ].each do |fiscal_year, workplace_type, city_category, co2_emission_factor, co2_emission_factor_unit|
    Co2EmissionFactor.find_or_create_by(
      { fiscal_year: fiscal_year,
        workplace_type: workplace_type,
        city_category: city_category,
        co2_emission_factor: co2_emission_factor,
        co2_emission_factor_unit: co2_emission_factor_unit
      }
    )
  end
end

# 以下はアプリ使用者側の初期データ

4.times do |i|
  Company.find_or_create_by(
    name: "会社#{i + 2}",
    contact_name: "ユーザ#{i + 1}",
    contact_email: "user#{i + 1}@email.com",
    status: i % 4,
  )
end

# 企業に紐づく、ユーザ、支店を作成。その後、ユーザ、支店に紐づく支店実績を作成
Company.where.not(name: "アプリ提供会社").each do |company|
  4.times do |i|
    unless User.find_by(email: "user#{i + 1}@email.com")
      company.users.create!(
        name: "#{company.name}のユーザ#{i + 1}",
        email: "com#{company.id}_user#{i + 1}@email.com",
        password: "password",
        password_confirmation: "password",
      )
    end
  end

  user = User.last
  5.times do |i|
    branch = company.branches.find_or_create_by(
      name: "#{company.name}の支店#{i + 1}",
      workplace_type: i % 2,
      city_category: i % 5,
      prefecture: "#{i + 1}県",
      city: "#{i + 1}市",
    )

    5.times do |j|
      break if j == 4 && i % 3 == 0
      branch.branch_fiscal_year_stats.find_or_create_by(
        fiscal_year: (2020 + j).to_s,
        annual_working_days: 200 + j,
        annual_employee_count: 25 + j,
        user_id: user.id
      )
    end
  end
end
