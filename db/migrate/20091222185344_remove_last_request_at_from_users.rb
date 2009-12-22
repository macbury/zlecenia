class RemoveLastRequestAtFromUsers < ActiveRecord::Migration
  def self.up
		remove_column :users, :last_request_at
		remove_column :users, :last_login_at
		remove_column :users, :current_login_at
		remove_column :users, :last_login_ip
		remove_column :users, :current_login_ip
  end

  def self.down
  end
end
