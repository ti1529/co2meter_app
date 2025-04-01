class BranchFiscalYearStat < ApplicationRecord
  belongs_to :branch
  belongs_to :user

  validates :fiscal_year, presence: true, length: { is: 4 }
  validates :branch_id, presence: true
  validates :annual_working_days, presence: true, numericality: { less_than_or_equal_to: 365 }
  validates :annual_employee_count, presence: true
  validates :user_id, presence: true
end
