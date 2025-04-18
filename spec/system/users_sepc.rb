require 'rails_helper'

RSpec.describe 'ユーザ管理機能', type: :system, selenium: true do
  include LoginMacro

  let!(:user) { FactoryBot.create(:user) }
  let!(:admin) { FactoryBot.create(:admin) }

  describe 'ログイン機能' do
    before do
      login_as(user)
    end

    context '登録済みのユーザがログインした場合' do
      it 'ダッシュボード画面に遷移し、「ログインしました」というメッセージが表示される' do
        expect(page).to have_selector "h1", text: "ダッシュボード"
        expect(page).to have_content "ログインしました"
      end

      it '自分の詳細画面にアクセスできる' do
        find("#users-show").click
        expect(page).to have_selector "h1", text: "アカウント詳細"
        expect(current_path).to eq user_path(user.id)
      end

      it '他人の詳細画面にアクセスすると、自分の詳細画面に遷移し、「アクセス権限がありません」というメッセージが表示される' do
        visit user_path(admin.id)
        expect(page).to have_content "アクセス権限がありません"
        expect(current_path).to eq user_path(user.id)
      end

      it 'ログアウトすると「ログイン」画面に遷移し、「ログアウトしました」というメッセージが表示される' do
        find("#sign-out").click
        expect(page).to have_content "ログアウトしました"
        expect(current_path).to eq new_user_session_path
      end
    end


    describe 'ユーザ登録機能' do
      context 'ログイン済みのユーザが新しいユーザを登録した場合' do
        it 'ユーザ一覧画面に遷移し、「アカウント登録が完了しました」というメッセージが表示される' do
          find("#users-index").click
          find("#users-new").click
          fill_in "user_name", with: "user_new"
          fill_in "user_email", with: "user_new@email.com"
          fill_in "user_password", with: "password"
          fill_in "user_password_confirmation", with: "password"
          find("#create-user").click
          expect(page).to have_content "アカウント登録が完了しました"
          expect(current_path).to eq users_path
        end
      end
    end

    describe 'アカウント更新機能' do
      context '自分のアカウントを更新した場合' do
        it 'アカウント詳細画面へ遷移し、「アカウント情報を変更しました」というメッセージが表示される' do
          find("#users-show").click
          find("#users-edit").click
          fill_in "user_name", with: "#{user.name}_edit"
          fill_in "user_current_password", with: "password65432123"
          find("#update-user").click
          expect(page).to have_content "アカウント情報を変更しました"
          expect(current_path).to eq user_path(user.id)
        end
      end
    end

    describe 'アカウント削除機能' do
      context '自分のアカウントを削除した場合' do
        it 'ログイン画面に遷移し、「アカウントを削除しました」というメッセージが表示される' do
          find("#users-show").click
          find("#users-edit").click
          find("#destroy-user").click
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content "アカウントを削除しました"
          expect(current_path).to eq new_user_session_path
        end
      end
    end

    describe 'アカウント削除機能' do
      context '自分のアカウントを削除した場合' do
        it 'ログイン画面に遷移し、「アカウントを削除しました」というメッセージが表示される' do
          find("#users-show").click
          find("#users-edit").click
          find("#destroy-user").click
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content "アカウントを削除しました"
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end

  describe '管理者機能' do
    before do
      login_as(admin)
    end
    context '管理者がログインした場合' do
      it 'ユーザ一覧画面（管理者用）にアクセスできる' do
        find("#admin-users-index").click
        expect(page).to have_selector "h1", text: "ユーザ一覧（管理者用）"
        expect(current_path).to eq admin_users_path
      end

      it '管理者を新規登録できる' do
        find("#admin-users-index").click
        find("#admin-users-new").click

        fill_in "user_name", with: "admin_new"
        select admin.company.name, from: "user_company_id"
        fill_in "user_email", with: "admin_new@email.com"
        fill_in "user_password", with: "password65432123"
        fill_in "user_password_confirmation", with: "password65432123"
        check "user_admin"
        find("#create-admin-user").click

        expect(page).to have_content "ユーザ登録が完了しました"
        expect(current_path).to eq admin_users_path
        expect(page).to have_content "admin_new"
      end

      it 'ユーザ編集画面から自分以外のユーザを編集できる' do
        find("#admin-users-index").click
        click_link "編集", href: edit_admin_user_path(user)

        fill_in "user_name", with: "#{user.name}_edit"
        fill_in "user_password", with: "password65432123"
        fill_in "user_password_confirmation", with: "password65432123"
        find("#update-admin-user").click

        expect(page).to have_content "ユーザ情報を更新しました"
        expect(current_path).to eq admin_users_path
        expect(page).to have_content "#{user.name}_edit"
      end

      it 'ユーザを削除できる' do
        find("#admin-users-index").click
        click_link "削除", href: "/admin/users/#{user.id}"
        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content "ユーザを削除しました"
        expect(current_path).to eq admin_users_path
        expect(page).not_to have_content "#{user.name}"
      end
    end
  end

  describe '一般ユーザのアクセス制限' do
    before do
      login_as(user)
    end
    context '一般ユーザがユーザ一覧画面（管理者用）にアクセスした場合' do
      it 'ダッシュボード画面に遷移し、「アクセス権限がありません」というメッセージが表示される' do
        visit admin_users_path
        expect(page).to have_content "アクセス権限がありません"
        expect(page).to have_selector "h1", text: "ダッシュボード"
      end
    end

    context '一般ユーザが企業一覧画面にアクセスした場合' do
      it 'ダッシュボード画面に遷移し、「アクセス権限がありません」というメッセージが表示される' do
        visit companies_path
        expect(page).to have_content "アクセス権限がありません"
        expect(page).to have_selector "h1", text: "ダッシュボード"
      end
    end

    context '一般ユーザが排出係数登録画面にアクセスした場合' do
      it 'ダッシュボード画面に遷移し、「アクセス権限がありません」というメッセージが表示される' do
        visit new_co2_emission_factor_path
        expect(page).to have_content "アクセス権限がありません"
        expect(page).to have_selector "h1", text: "ダッシュボード"
      end
    end
  end
end
