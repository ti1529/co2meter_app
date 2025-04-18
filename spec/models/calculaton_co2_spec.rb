require 'rails_helper'

RSpec.describe "CO2排出量の算定機能", type: :model do
  # let!(:office_2020_co2_factors) { FactoryBot.create_list(:co2_emission_factor_office, 5, fiscal_year: "2020") }
  # let!(:factory_2020_co2_factors) { FactoryBot.create_list(:co2_emission_factor_factory, 5, fiscal_year: "2020") }

  let!(:office_major_city_2020_factor) { FactoryBot.create(:co2_emission_factor, co2_emission_factor: 2) }

  let!(:branch_office_major_city) { FactoryBot.create(:branch) }
  let!(:stat_2020) { FactoryBot.create(:branch_fiscal_year_stat, branch: branch_office_major_city) }
  let!(:stat_2021) { FactoryBot.create(:branch_fiscal_year_stat, branch: branch_office_major_city, fiscal_year: "2021") }


  describe '算定機能' do
    context '同じ年度において、支店実績と排出係数が登録されている場合' do
      it 'CO2排出量が算定される' do
        expect(stat_2020.calculated_co2_emission).to eq (240*20*2/1000.to_f)
      end
    end
    context '同じ年度において、支店実績は登録されているが、排出係数が登録されていない場合' do
      it 'CO2排出量がゼロとなる' do
        expect(stat_2021.calculated_co2_emission).to eq (0)
      end
    end
  end
end
