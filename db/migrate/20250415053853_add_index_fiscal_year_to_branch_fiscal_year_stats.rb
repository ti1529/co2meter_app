class AddIndexFiscalYearToBranchFiscalYearStats < ActiveRecord::Migration[7.2]
  def change
    add_index :branch_fiscal_year_stats, [ :fiscal_year, :branch_id ], unique: true
  end
end
