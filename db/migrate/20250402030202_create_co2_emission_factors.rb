class CreateCo2EmissionFactors < ActiveRecord::Migration[7.2]
  def change
    create_table :co2_emission_factors do |t|
      t.string :fiscal_year, null: false, limit: 4
      t.integer :workplace_type, null: false
      t.integer :city_category, null: false
      t.float :co2_emission_factor, null: false
      t.string :co2_emission_factor_unit, null: false

      t.timestamps
    end
  end
end
