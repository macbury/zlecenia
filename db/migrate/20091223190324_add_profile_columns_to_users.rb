class AddProfileColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :goldenline, :string
    add_column :users, :profeo, :string
  end

  def self.down
    remove_column :users, :profeo
    remove_column :users, :goldenline
  end
end
