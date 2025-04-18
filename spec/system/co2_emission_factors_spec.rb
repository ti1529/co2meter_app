require 'rails_helper'

RSpec.describe "Co2EmissionFactors", type: :system, selenium: true do
  include LoginMacro

  let!(:admin) { FactoryBot.create(:admin) }

  let!(:office_2024_co2_factors) { FactoryBot.create_list(:co2_emission_factor_office, 5, fiscal_year: "2024") }
  let!(:factory_2024_co2_factors) { FactoryBot.create_list(:co2_emission_factor_factory, 5, fiscal_year: "2024") }
  let!(:office_2025_co2_factors) { FactoryBot.create_list(:co2_emission_factor_office, 5, fiscal_year: "2025") }
  let!(:factory_2025_co2_factors) { FactoryBot.create_list(:co2_emission_factor_factory, 5, fiscal_year: "2025") }

  before do
    login_as(admin)
  end

  describe '登録機能' do
    context '排出係数を登録した場合' do
      it '排出係数一覧画面に遷移し、「排出係数を登録しました」というメッセージが表示される' do
        find("#co2-emission-factors-index").click
        find("#co2-emission-factors-new").click

        select "2030", from: "co2_emission_factor_fiscal_year"
        select "オフィス", from: "co2_emission_factor_workplace_type"
        select "大都市", from: "co2_emission_factor_city_category"
        fill_in "co2_emission_factor_co2_emission_factor", with: 10
        select "kgCO2/人・日", from: "co2_emission_factor_co2_emission_factor_unit"

        expect {
          click_on "登録する"
          expect(page).to have_content "排出係数を登録しました"
        }.to change { Co2EmissionFactor.count }.by(1)
      end
    end
  end

  describe '更新機能' do
    context '排出係数を更新した場合' do
      it '排出係数一覧画面に遷移し、「排出係数を更新しました」というメッセージが表示される' do
        find("#co2-emission-factors-index").click
        click_link "編集", href: edit_co2_emission_factor_path(office_2024_co2_factors.first.id)

        fill_in "co2_emission_factor_co2_emission_factor", with: 1000
        click_on "更新する"

        expect(page).to have_content "排出係数を更新しました"
        expect(page).to have_selector "td", text: 1000
      end
    end
  end

  describe '削除機能' do
    context '排出係数を削除した場合' do
      it '排出係数一覧画面に遷移し、「排出係数を削除しました」というメッセージが表示される' do
        find("#co2-emission-factors-index").click
        click_link "削除", href: "/co2_emission_factors/#{office_2024_co2_factors.first.id}"

        expect {
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content "排出係数を削除しました"
        }.to change { Co2EmissionFactor.count }.by(-1)
      end
    end
  end
end
