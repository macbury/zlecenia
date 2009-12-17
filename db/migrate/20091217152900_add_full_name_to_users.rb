class AddFullNameToUsers < ActiveRecord::Migration
  def self.up
		add_column :users, :first_name, :string
		add_column :users, :last_name, :string
		add_column :users, :sex, :integer, :default => 0
		add_column :users, :birthdate, :date
		add_column :users, :website, :string
		add_column :users, :phone, :string
		add_column :users, :company, :string
		add_column :users, :place_id, :integer
		add_column :users, :type_id, :integer, :default => 0
  end

  def self.down
		remove_column :users, :first_name
		remove_column :users, :last_name
		remove_column :users, :sex
		remove_column :users, :birthdate
		remove_column :users, :website
		remove_column :users, :phone
		remove_column :users, :company
		remove_column :users, :place_id
		remove_column :users, :type_id
  end
end
