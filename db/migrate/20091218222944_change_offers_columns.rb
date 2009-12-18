class ChangeOffersColumns < ActiveRecord::Migration
  def self.up
		remove_column :offers, :category_id
		add_column :offers, :earnings_min, :integer
		add_column :offers, :earnings_max, :integer
		add_column :offers, :etat, :bool, :default => false
		 
  end

  def self.down
  end
end
