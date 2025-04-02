require 'rails_helper'

RSpec.describe BranchFiscalYearStat, type: :model do
  describe 'バリデーションのテスト' do
    context '支店実績の年度が空文字の場合' do
      it 'バリデーションに失敗する' do
        stat = FactoryBot.build(:branch_fiscal_year_stat, fiscal_year: "")
        expect(stat).not_to be_valid
      end
    end

    context '支店実績の年間勤務日数が空文字の場合' do
      it 'バリデーションに失敗する' do
        stat = FactoryBot.build(:branch_fiscal_year_stat, annual_working_days: "")
        expect(stat).not_to be_valid
      end
    end

    context '支店実績の年間勤務日数が400日の場合' do
      it 'バリデーションに失敗する' do
        stat = FactoryBot.build(:branch_fiscal_year_stat, annual_working_days: 400)
        expect(stat).not_to be_valid
      end
    end

    context '支店実績の従業員数が空文字の場合' do
      it 'バリデーションに失敗する' do
        stat = FactoryBot.build(:branch_fiscal_year_stat, annual_employee_count: "")
        expect(stat).not_to be_valid
      end
    end

    context '年度、年間勤務日数、従業員数に値がある場合' do
      it '支店を登録できる' do
        stat = FactoryBot.build(:branch_fiscal_year_stat)
        stat.updater.save
        stat.branch.company = stat.updater.company
        stat.branch.save
        expect(stat.save).to be_truthy
      end
    end
  end
end
