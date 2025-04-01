class CreateBranches < ActiveRecord::Migration[7.2]
  def change
    create_table :branches do |t|
      t.string :name, null: false
      t.integer :workplace_type, null: false
      t.integer :city_category, null: false
      t.string :postcode
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address_line1
      t.string :address_line2
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
