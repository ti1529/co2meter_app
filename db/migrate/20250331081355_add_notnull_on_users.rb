class AddNotnullOnUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_null :users, :company_id, false
  end
end
