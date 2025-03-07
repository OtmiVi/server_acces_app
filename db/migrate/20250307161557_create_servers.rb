class CreateServers < ActiveRecord::Migration[8.0]
  def change
    create_table :servers do |t|
      t.string :name
      t.string :username
      t.string :host
      t.string :password
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
