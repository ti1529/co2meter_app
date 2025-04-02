require 'rails_helper'

RSpec.describe Branch, type: :model do
  describe 'バリデーションのテスト' do
    context '支店名が空文字の場合' do
      it 'バリデーションに失敗する' do
        branch = FactoryBot.build(:branch, name: "")
        expect(branch).not_to be_valid
      end
    end

    context '支店の勤務形態が空文字の場合' do
      it 'バリデーションに失敗する' do
        branch = FactoryBot.build(:branch, workplace_type: "")
        expect(branch).not_to be_valid
      end
    end

    context '支店の都市区分が空文字の場合' do
      it 'バリデーションに失敗する' do
        branch = FactoryBot.build(:branch, city_category: "")
        expect(branch).not_to be_valid
      end
    end

    context '支店の郵便番号が1文字の場合' do
      it 'バリデーションに失敗する' do
        branch = FactoryBot.build(:branch, postcode: "1")
        expect(branch).not_to be_valid
      end
    end

    context '支店の都道府県が空文字の場合' do
      it 'バリデーションに失敗する' do
        branch = FactoryBot.build(:branch, prefecture: "")
        expect(branch).not_to be_valid
      end
    end

    context '支店の市町村が空文字の場合' do
      it 'バリデーションに失敗する' do
        branch = FactoryBot.build(:branch, city: "")
        expect(branch).not_to be_valid
      end
    end

    context '支店の企業idが空文字の場合' do
      it '支店の登録に失敗する' do
        branch = FactoryBot.build(:branch, company_id: "")
        expect(branch.save).to be_falsey
      end
    end

    context '支店名、勤務形態、都市区分、都道府県、住所、企業idに値があり、郵便番号が空文字の場合' do
      it '支店を登録できる' do
        branch = FactoryBot.build(:branch, postcode: "")
        expect(branch.save).to be_truthy
      end
    end

    context '支店名、勤務形態、都市区分、都道府県、住所、企業idに値があり、郵便番号が7文字の場合' do
      it '支店を登録できる' do
        branch = FactoryBot.build(:branch)
        expect(branch.save).to be_truthy
      end
    end
  end
end
