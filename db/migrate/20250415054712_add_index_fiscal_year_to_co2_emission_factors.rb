class AddIndexFiscalYearToCo2EmissionFactors < ActiveRecord::Migration[7.2]
  def change
    add_index :co2_emission_factors, [ :fiscal_year, :workplace_type, :city_category ], unique: true
  end
end
