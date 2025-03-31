class CreateCompanies < ActiveRecord::Migration[7.2]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :contact_name, null: false
      t.string :contact_email
      t.integer :status, null: false

      t.timestamps
      t.index :name, unique: true
    end
  end
end
