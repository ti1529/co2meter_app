require 'rails_helper'

RSpec.describe "BranchFiscalYearStats", type: :system, selenium: true do
  include LoginMacro

  let!(:user) { FactoryBot.create(:user) }
  let!(:branch) { FactoryBot.create(:branch, company: user.company) }
  let!(:branch_fiscal_year_stat) { FactoryBot.create(:branch_fiscal_year_stat, branch: branch, updater: user) }
  let!(:branch_fiscal_year_stat_2) { FactoryBot.create(:branch_fiscal_year_stat_2, branch: branch, updater: user) }
  let!(:branch_fiscal_year_stat_3) { FactoryBot.create(:branch_fiscal_year_stat_3, branch: branch, updater: user) }

  let!(:branch_2) { FactoryBot.create(:branch_2, company: user.company) }
  let!(:branch2_fiscal_year_stat) { FactoryBot.create(:branch_fiscal_year_stat, branch: branch_2, updater: user) }
  let!(:branch2_fiscal_year_stat_2) { FactoryBot.create(:branch_fiscal_year_stat_2, branch: branch_2, updater: user) }
  let!(:branch2_fiscal_year_stat_3) { FactoryBot.create(:branch_fiscal_year_stat_3, branch: branch_2, updater: user) }

  before do
    login_as(user)
  end

  describe '登録機能' do
    context '支店実績を登録した場合' do
      it '支店実績一覧画面に遷移し、「実績を登録しました」というメッセージが表示される' do
        find("#branches-index").click
        click_link "実績一覧", href: "/branch_fiscal_year_stats?q%5Bbranch_id_eq%5D=#{branch.id}"
        find("#branch-fiscal-year-stats-new").click

        select "2024", from: "branch_fiscal_year_stat_fiscal_year"
        select branch.name, from: "branch_fiscal_year_stat_branch_id"
        fill_in "branch_fiscal_year_stat_annual_working_days", with: 210
        fill_in "branch_fiscal_year_stat_annual_employee_count", with: 30

        expect {
          click_on "登録する"
          expect(page).to have_content "実績を登録しました"
        }.to change { BranchFiscalYearStat.count }.by(1)
      end
    end
  end

  describe '更新機能' do
    context '支店実績を更新した場合' do
      it '支店実績一覧画面に遷移し、「実績を修正しました」というメッセージが表示される' do
        find("#branches-index").click
        click_link "実績一覧", href: "/branch_fiscal_year_stats?q%5Bbranch_id_eq%5D=#{branch.id}"
        click_link "修正", href: edit_branch_fiscal_year_stat_path(branch_fiscal_year_stat.id)

        fill_in "branch_fiscal_year_stat_annual_employee_count", with: 50
        click_on "修正する"

        expect(page).to have_content "実績を修正しました"
        expect(page).to have_selector "td", text: 50
      end
    end
  end

  describe '削除機能' do
    context '支店実績を削除した場合' do
      it '支店実績一覧画面に遷移し、「実績を登録しました」というメッセージが表示される' do
        find("#branches-index").click
        click_link "実績一覧", href: "/branch_fiscal_year_stats?q%5Bbranch_id_eq%5D=#{branch.id}"
        click_link "削除", href: "/branch_fiscal_year_stats/#{branch_fiscal_year_stat.id}"

        expect {
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content "実績を削除しました"
        }.to change { BranchFiscalYearStat.count }.by(-1)
      end
    end
  end

  describe '一覧画面' do
    context '支店一覧から、支店実績一覧画面に遷移した場合' do
      it 'その支店と一致する支店実績の一覧が、年度の降順で表示される' do
        find("#branches-index").click
        click_link "実績一覧", href: "/branch_fiscal_year_stats?q%5Bbranch_id_eq%5D=#{branch.id}"

        within all("tbody tr").first do
          expect(page).to have_selector "td", text:  "2022"
          expect(page).to have_selector "td", text:  branch.name
        end
        within all("tbody tr").last do
          expect(page).to have_selector "td", text:  "2020"
          expect(page).to have_selector "td", text:  branch.name
        end
      end
    end

    describe 'ソート機能' do
      context '「年度」というリンクをクリックした場合' do
        it '年度の昇順に並び替えられた支店実績が表示される' do
          find("#branches-index").click
          click_link "実績一覧", href: "/branch_fiscal_year_stats?q%5Bbranch_id_eq%5D=#{branch.id}"
          click_link "年度"

          within all("tbody tr").first do
            expect(page).to have_selector "td", text:  "2020"
            expect(page).to have_selector "td", text:  branch.name
          end
          within all("tbody tr").last do
            expect(page).to have_selector "td", text:  "2022"
            expect(page).to have_selector "td", text:  branch.name
          end
        end
      end
    end

    describe '検索機能' do
      context '期間（年度）で検索した場合' do
        it 'その期間の支店実績のみ表示される' do
          find("#branches-index").click
          click_link "実績一覧", href: "/branch_fiscal_year_stats?q%5Bbranch_id_eq%5D=#{branch.id}"

          select "2021", from: "q_fiscal_year_gteq"
          select "2022", from: "q_fiscal_year_lteq"
          click_on "検索"
          sleep 0.1

          within all("tbody").first do
            expect(page).to have_selector("td", text:  "2021", wait: 2)
            expect(page).to have_selector "td", text:  "2022"
            expect(page).not_to have_selector "td", text:  "2020"
          end
        end
      end

      context '支店名で検索した場合' do
        it '一致する支店の支店実績のみ表示される' do
          find("#branches-index").click
          click_link "実績一覧", href: "/branch_fiscal_year_stats?q%5Bbranch_id_eq%5D=#{branch.id}"

          select branch_2.name, from: "q_branch_id_eq"
          click_on "検索"
          sleep 0.1

          within all("tbody").first do
            expect(page).to have_selector("td", text: branch_2.name, wait: 2)
            expect(page).not_to have_selector "td", text:  branch.name
          end
        end
      end

      context '期間（年度）と支店名で検索した場合' do
        it 'その期間内であり、かつ、支店が一致する支店実績のみ表示される' do
          find("#branches-index").click
          click_link "実績一覧", href: "/branch_fiscal_year_stats?q%5Bbranch_id_eq%5D=#{branch.id}"

          select "2021", from: "q_fiscal_year_gteq"
          select "2022", from: "q_fiscal_year_lteq"
          select branch_2.name, from: "q_branch_id_eq"
          click_on "検索"
          sleep 0.1

          within all("tbody").first do
            expect(page).to have_selector("td", text:  "2021", wait: 2)
            expect(page).to have_selector "td", text:  "2022"
            expect(page).not_to have_selector "td", text:  "2020"
            expect(page).not_to have_selector "td", text:  branch.name
            expect(page).to have_selector "td", text: branch_2.name
          end
        end
      end
    end
  end
end
