require 'rails_helper'

RSpec.describe "企業管理機能", type: :system, selenium: true do
  include LoginMacro
  let!(:company) { FactoryBot.create(:company) }
  let!(:admin) { FactoryBot.create(:admin) }

  before do
    login_as(admin)
  end

  describe '登録機能' do
    context '企業を登録した場合' do
      it '企業一覧画面に遷移し、「企業情報を登録しました」というメッセージが表示される' do
        find("#companies-index").click
        find("#companies-new").click

        fill_in "company_name", with: "company_new"
        fill_in "company_contact_name", with: "ユーザ"
        select "未契約", from: "company_status"
        click_on "登録する"

        expect(page).to have_content "企業情報を登録しました"
        expect(page).to have_content "company_new"
        expect(current_path).to eq companies_path
      end
    end
  end

  describe '更新機能' do
    context '企業情報を更新した場合' do
      it '企業詳細画面に遷移し、「企業情報を更新しました」というメッセージが表示される' do
        find("#companies-index").click
        click_link "編集", href: edit_company_path(company.id)

        fill_in "company_name", with: "#{company.name}_edit"
        click_on "更新する"

        expect(page).to have_content "企業情報を更新しました"
        expect(page).to have_content "#{company.name}_edit"
        expect(current_path).to eq company_path(company.id)
      end
    end
  end

  describe '削除機能' do
    context '企業を削除した場合' do
      it '企業一覧画面に遷移し、「企業情報を削除しました」というメッセージが表示される' do
        find("#companies-index").click
        click_link "詳細", href: company_path(company.id)

        find("#destroy-company").click
        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content "企業情報を削除しました"
        expect(page).not_to have_content "#{company.name}"
        expect(current_path).to eq companies_path
      end
    end
  end
end
