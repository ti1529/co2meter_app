class BranchFiscalYearStat < ApplicationRecord
  belongs_to :branch
  belongs_to :updater, class_name: "User", foreign_key: "user_id"

  validates :fiscal_year, presence: true, length: { is: 4 }
  validates :annual_working_days, presence: true, numericality: { less_than_or_equal_to: 365 }
  validates :annual_employee_count, presence: true
end
