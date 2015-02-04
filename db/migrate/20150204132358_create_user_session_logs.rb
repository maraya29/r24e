class CreateUserSessionLogs < ActiveRecord::Migration

  def change
    create_table :user_session_logs do |t|
      t.integer :user_id,                       null: false
      t.string :session_id,                     :limit => 200, null: false
      t.string :ip_address,                     :limit => 200
      t.integer :login_count,                   :default => 0, null: false
      t.timestamps :login_timestamp,            :default => '''now()'''
      t.timestamps :last_accessed_timestamp,    :default => '''now()'''
      t.timestamps
    end
  end

end

