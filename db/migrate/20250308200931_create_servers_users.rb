class CreateServersUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :servers_users do |t|
      t.references :server, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    add_index :servers_users, [ :server_id, :user_id ], unique: true

    remove_reference :servers, :user, foreign_key: true
  end
end
