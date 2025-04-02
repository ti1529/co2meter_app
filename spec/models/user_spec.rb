require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    context 'ユーザの名前が空文字の場合' do
      it 'バリデーションに失敗する' do
        user = FactoryBot.build(:user, name: "")
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのメールアドレスが空文字の場合' do
      it 'バリデーションに失敗する' do
        user = FactoryBot.build(:user, email: "")
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのメールアドレスがすでに使用されていた場合' do
      it 'バリデーションに失敗する' do
        FactoryBot.create(:user)
        user_new = FactoryBot.build(:user, name: "user_new")
        expect(user_new).not_to be_valid
      end
    end

    context 'ユーザのパスワードが6文字未満の場合' do
      it 'バリデーションに失敗する' do
        user = FactoryBot.build(:user, password: "pass")
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのパスワードとパスワード（確認）が一致しない場合' do
      it 'バリデーションに失敗する' do
        user = FactoryBot.build(:user, password_confirmation: "passpass")
        expect(user).not_to be_valid
      end
    end

    context 'ユーザの企業idが空文字の場合' do
      it 'ユーザの登録に失敗する' do
        user = FactoryBot.build(:user, company_id: "")
        expect(user.save).to be_falsey
      end
    end

    context 'ユーザの名前、企業idに値があり、メールアドレスが使われていない値で、かつパスワードが6文字以上でパスワード（確認）と一致する場合' do
      it 'ユーザを登録できる' do
        user = FactoryBot.build(:user)
        expect(user.save).to be_truthy
      end
    end
  end
end
