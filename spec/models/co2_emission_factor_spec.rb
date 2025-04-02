require 'rails_helper'

RSpec.describe Co2EmissionFactor, type: :model do
  describe 'バリデーションのテスト' do
    context '排出係数の年度が空文字の場合' do
      it 'バリデーションに失敗する' do
        factor = FactoryBot.build(:co2_emission_factor, fiscal_year: "")
        expect(factor).not_to be_valid
      end
    end

    context '排出係数の年度が3桁の場合' do
      it 'バリデーションに失敗する' do
        factor = FactoryBot.build(:co2_emission_factor, fiscal_year: "202")
        expect(factor).not_to be_valid
      end
    end

    context '排出係数の勤務形態が空文字の場合' do
      it 'バリデーションに失敗する' do
        factor = FactoryBot.build(:co2_emission_factor, workplace_type: "")
        expect(factor).not_to be_valid
      end
    end

    context '排出係数の都市区分が空文字の場合' do
      it 'バリデーションに失敗する' do
        factor = FactoryBot.build(:co2_emission_factor, city_category: "")
        expect(factor).not_to be_valid
      end
    end

    context '排出係数の排出係数（数値）が空文字の場合' do
      it 'バリデーションに失敗する' do
        factor = FactoryBot.build(:co2_emission_factor, co2_emission_factor: "")
        expect(factor).not_to be_valid
      end
    end

    context '排出係数の排出係数（数値）が負の値の場合' do
      it 'バリデーションに失敗する' do
        factor = FactoryBot.build(:co2_emission_factor, co2_emission_factor: -1)
        expect(factor).not_to be_valid
      end
    end

    context '排出係数の排出係数（単位）が空文字の場合' do
      it 'バリデーションに失敗する' do
        factor = FactoryBot.build(:co2_emission_factor, co2_emission_factor_unit: "")
        expect(factor).not_to be_valid
      end
    end


    context '排出係数の年度、勤務形態、都市区分、CO2排出係数（単位）に値があり、CO2排出係数（数値）が正の値の場合' do
      it 'バリデーションに成功する' do
        factor = FactoryBot.build(:co2_emission_factor)
        expect(factor).to be_valid
      end
    end
  end
end
