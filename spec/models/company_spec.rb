require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'バリデーションのテスト' do
    context '企業名が空文字の場合' do
      it 'バリデーションに失敗する' do
        company = FactoryBot.build(:company, name: "")
        expect(company).not_to be_valid
      end
    end

    context '企業名がすでに使用されている場合' do
      it 'バリデーションに失敗する' do
        FactoryBot.create(:company, name: "user_1")
        new_company = FactoryBot.build(:company, name: "user_1")
        expect(new_company).not_to be_valid
      end
    end

    context '担当者名が空文字の場合' do
      it 'バリデーションに失敗する' do
        company = FactoryBot.build(:company, contact_name: "")
        expect(company).not_to be_valid
      end
    end

    context '契約情報が空文字の場合' do
      it 'バリデーションに失敗する' do
        company = FactoryBot.build(:company, status: "")
        expect(company).not_to be_valid
      end
    end

    context '企業名が既に使用されておらず、担当者名、契約情報に値があり、担当者メールアドレスが空文字の場合' do
      it 'バリデーションに成功する' do
        company = FactoryBot.build(:company, contact_email: "")
        expect(company).to be_valid
      end
    end

    context '企業名が既に使用されておらず、担当者名、契約情報、担当者メールアドレスに値がある場合' do
      it 'バリデーションに成功する' do
        company = FactoryBot.build(:company)
        expect(company).to be_valid
      end
    end
  end
end
