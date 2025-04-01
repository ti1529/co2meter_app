class CreateBranchFiscalYearStats < ActiveRecord::Migration[7.2]
  def change
    create_table :branch_fiscal_year_stats do |t|
      t.string :fiscal_year, null: false, limit: 4
      t.references :branch, null: false, foreign_key: true
      t.integer :annual_working_days, null: false
      t.integer :annual_employee_count, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
