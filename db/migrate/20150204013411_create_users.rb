class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :login_count, null: false, :default => 0
      t.integer :failed_login_count, null: false, :default => 0
      t.datetime :last_login_at
      t.timestamps null: false
    end
  end
end
