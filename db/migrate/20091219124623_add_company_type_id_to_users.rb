class AddCompanyTypeIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :osoba_prywatna, :bool, :default => false
  end

  def self.down
    remove_column :users, :osoba_prywatna
  end
end
