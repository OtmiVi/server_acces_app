class ChangeDefaultRoleToUsers < ActiveRecord::Migration[8.0]
  def change
    change_column :users, :role, :string, default: 1, null: false
  end
end
