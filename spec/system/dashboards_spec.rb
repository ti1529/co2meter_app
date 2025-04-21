require 'rails_helper'

RSpec.describe "Dashboards", type: :system, selenium: true do
  include LoginMacro

  let!(:user) { FactoryBot.create(:user) }

  let!(:branch_1) { FactoryBot.create(:branch, company: user.company) }
  let!(:branch_1_stats) { FactoryBot.create_list(:branch_fiscal_year_stat_n1, 2, branch: branch_1, updater: user) }

  let!(:branch_2) { FactoryBot.create(:branch_2, company: user.company) }
  let!(:branch_2_stats) { FactoryBot.create_list(:branch_fiscal_year_stat_n2, 2, branch: branch_2, updater: user) }

  let!(:office_2024_co2_factors) { FactoryBot.create_list(:co2_emission_factor_office, 5, fiscal_year: "2024") }
  let!(:factory_2024_co2_factors) { FactoryBot.create_list(:co2_emission_factor_factory, 5, fiscal_year: "2024") }
  let!(:office_2025_co2_factors) { FactoryBot.create_list(:co2_emission_factor_office, 5, fiscal_year: "2025") }
  let!(:factory_2025_co2_factors) { FactoryBot.create_list(:co2_emission_factor_factory, 5, fiscal_year: "2025") }

  before do
    login_as(user)
    FactoryBot.rewind_sequences
  end

  describe '算定結果の表示機能' do
    context '支店実績が入力されている場合' do
      it '算定結果が表示される' do
        within all("tbody tr").first do
          expect(page).to have_selector "td", text: branch_1_stats.last.fiscal_year
          expect(page).to have_selector "td", text: branch_1.name
          expect(page).to have_selector "td", text: branch_1_stats.last.calculated_co2_emission.round(2)
        end
      end
    end

    context '支店実績が入力されていない場合' do
      it '「データなし」と表示される' do
        branch_2_stats.last.destroy
        visit current_path

        within all("tbody").first do
          expect(page).to have_selector "td", text: "データなし"
        end
      end
    end

    describe 'ソート機能' do
      context '「年度」というヘッダーをクリックした場合' do
        it '年度の昇順に並び替えらる' do
          find(".datatable-sorter", text: "年度").click
          sleep 0.1
          within all("tbody tr").first do
            expect(page).to have_selector "td", text: "2024"
          end
          within all("tbody tr").last do
            expect(page).to have_selector "td", text: "2025"
          end
        end
      end

      context '「支店名」というヘッダーをクリックした場合' do
        it '支店名の昇順に並び替えらる' do
          find(".datatable-sorter", text: "支店名").click
          sleep 0.1
          within all("tbody tr").first do
            expect(page).to have_selector "td", text: branch_1.name
          end
          within all("tbody tr").last do
            expect(page).to have_selector "td", text: branch_2.name
          end
        end
      end
    end

    describe '検索機能' do
      context '期間（年度）で検索した場合' do
        it 'その期間のCO2排出量（算定結果）のみ表示される' do
          select "2024", from: "q_fiscal_year_gteq"
          select "2024", from: "q_fiscal_year_lteq"
          click_on "表示"
          sleep 0.1
          within all("tbody").first do
            expect(page).to have_selector "td", text: "2024"
            expect(page).not_to have_selector "td", text: "2025"
          end
        end
      end

      context '支店名で検索した場合' do
        it 'その支店と一致する支店のCO2排出量（算定結果）のみ表示される' do
          select branch_2.name, from: "q_branch_id_eq"
          click_on "表示"
          sleep 0.1
          within all("tbody").first do
            expect(page).to have_selector "td", text: branch_2.name
            expect(page).not_to have_selector "td", text: branch_1.name
          end
        end
      end

      context '期間（年度）と支店名で検索した場合' do
        it 'その期間内であり、かつ、一致する支店のCO2排出量（算定結果）のみ表示される' do
          select "2024", from: "q_fiscal_year_gteq"
          select "2024", from: "q_fiscal_year_lteq"
          select branch_2.name, from: "q_branch_id_eq"
          click_on "表示"
          sleep 0.1

          within all("tbody").first do
            expect(page).to have_selector "td", text: "2024"
            expect(page).not_to have_selector "td", text: "2025"
            expect(page).to have_selector "td", text: branch_2.name
            expect(page).not_to have_selector "td", text: branch_1.name
          end
        end
      end

      context 'CO2排出量（ton）というヘッダーをクリックした場合' do
        it '実績データが入力されていない、支店と年度の一覧が表示される' do
          branch_2_stats.last.destroy
          visit current_path
          find(".datatable-filter", text: "CO2排出量（ton）").click
          sleep 0.1

          within all("tbody").first do
            expect(page).to have_selector "td", text: "2025"
            expect(page).to have_selector "td", text: branch_2.name
            expect(page).to have_selector "td", text: "データなし"
            expect(page).not_to have_selector "td", text: branch_1.name
            expect(page).not_to have_selector "td", text: "2024"
          end
        end
      end
    end
  end

  describe '実績の入力忘れ防止機能' do
    context '直近年度（例：2025年1月〜12月の場合、2024年度）の支店実績が未入力の支店があり、「一覧を確認するには、こちらをクリックしてください」というボタンをクリックした場合' do
      it '該当する支店が表示される' do
        BranchFiscalYearStat.find_by(branch_id: branch_2.id, fiscal_year: "2024").destroy
        visit current_path
        find("#branches-without-current-year-stat").click

        within all(".accordion-body").first do
          expect(page).to have_content branch_2.name
        end
      end
    end
  end
end
