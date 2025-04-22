require 'rails_helper'

RSpec.describe "支店管理機能", type: :system, selenium: true do
  include LoginMacro

  let!(:user) { FactoryBot.create(:user) }
  let!(:branch) { FactoryBot.create(:branch, company_id: user.company.id) }
  before do
    login_as(user)
  end

  describe '登録機能' do
    context '支店を登録した場合' do
      it '支店一覧画面に遷移し、「支店を登録しました」というメッセージが表示される' do
        find("#branches-index").click
        find("#branches-new").click

        fill_in "branch_name", with: "branch_new"
        select "工場", from: "branch_workplace_type"
        select "大都市", from: "branch_city_category"
        fill_in "branch_prefecture", with: "千葉県"
        fill_in "branch_city", with: "千葉市"
        click_on "登録する"

        expect(page).to have_content "支店を登録しました"
        expect(page).to have_content "branch_new"
        expect(current_path).to eq branches_path
      end
    end
  end

  describe '更新機能' do
    context '支店情報を更新した場合' do
      it '支店詳細画面に遷移し、「支店を更新しました」というメッセージが表示される' do
        find("#branches-index").click
        click_link "編集", href: edit_branch_path(branch.id)

        fill_in "branch_name", with: "#{branch.name}_edit"
        click_on "更新する"

        expect(page).to have_content "支店を更新しました"
        expect(page).to have_content "#{branch.name}_edit"
        expect(current_path).to eq branch_path(branch.id)
      end
    end
  end

  describe '削除機能' do
    context '支店を削除した場合' do
      it '支店一覧画面に遷移し、「支店を削除しました」というメッセージが表示される' do
        find("#branches-index").click
        click_link "詳細", href: branch_path(branch.id)

        find("#destroy-branch").click
        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content "支店を削除しました"
        expect(page).not_to have_content "#{branch.name}"
        expect(current_path).to eq branches_path
      end
    end
  end

  describe '一覧機能' do
    let!(:branch_2) { FactoryBot.create(:branch, name: "支店_2") }

    context '支店一覧画面では' do
      it 'ログインユーザの所属する会社と一致する会社の支店が、一覧で表示される' do
        find("#branches-index").click

        expect(page).to have_selector "h1", text: "支店一覧"
        expect(page).to have_content "#{branch.name}"
        expect(page).not_to have_content "#{branch_2.name}"
        expect(current_path).to eq branches_path
      end
    end
  end
end
