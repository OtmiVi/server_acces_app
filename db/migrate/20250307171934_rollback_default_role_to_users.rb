class RollbackDefaultRoleToUsers < ActiveRecord::Migration[8.0]
  def change
    change_column :users, :role, :string, default: "user", null: false
  end
end
