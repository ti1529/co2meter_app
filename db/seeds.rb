# アプリ提供側の初期データ
company = Company.find_or_create_by(
  name: "アプリ提供会社",
  contact_name: "管理者",
  contact_email: "admin_1@email.com",
  status: 0,
)
unless User.find_by(email: "admin_1@email.com")
  company.users.create!(
  name: "管理者",
  email: "admin_1@email.com",
  password: "password",
  password_confirmation: "password",
  admin: true
  )
end


# （仮）Co2の排出係数。動作確認後、作成データ数と実際の排出係数を修正する
5.times do |i|
  [
    [ (2019 + i).to_s, 0, 0, 1, "kgCO2/人・日" ],
    [ (2019 + i).to_s, 0, 1, 2, "kgCO2/人・日" ],
    [ (2019 + i).to_s, 0, 2, 3, "kgCO2/人・日" ],
    [ (2019 + i).to_s, 0, 3, 4, "kgCO2/人・日" ],
    [ (2019 + i).to_s, 0, 4, 5, "kgCO2/人・日" ],

    [ (2019 + i).to_s, 1, 0, 6, "kgCO2/人・日" ],
    [ (2019 + i).to_s, 1, 1, 7, "kgCO2/人・日" ],
    [ (2019 + i).to_s, 1, 2, 8, "kgCO2/人・日" ],
    [ (2019 + i).to_s, 1, 3, 9, "kgCO2/人・日" ],
    [ (2019 + i).to_s, 1, 4, 10, "kgCO2/人・日" ]
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

2.times do |i|
  Company.find_or_create_by(
    name: "会社_#{i + 1}",
    contact_name: "ユーザ_#{i + 1}",
    contact_email: "user_#{i + 1}@email.com",
    status: (i + 1) % 4,
  )
end

# 企業に紐づく、ユーザ（一般及び管理者）、支店を作成
# （仮）最後に、Company.allにする
Company.where(name: "会社_1").each do |company|
  2.times do |i|
    unless User.find_by(email: "user_#{i + 1}@email.com")
      company.users.create!(
        name: "#{company.name}のユーザ_#{i + 1}",
        email: "user_#{i + 1}@email.com",
        password: "password",
        password_confirmation: "password",
      )
    end
  end

  user = User.last
  2.times do |i|
    branch = company.branches.find_or_create_by(
      name: "#{company.name}の支店_#{i + 1}",
      workplace_type: (i + 1) % 2,
      city_category: (i + 1) % 5,
      prefecture: "#{i + 1}県",
      city: "#{i + 1}市",
    )

    5.times do |j|
      branch.branch_fiscal_year_stats.find_or_create_by(
        fiscal_year: (2019 + j).to_s,
        annual_working_days: 200 + j,
        annual_employee_count: 25 + j,
        user_id: user.id
      )
    end
  end
end
