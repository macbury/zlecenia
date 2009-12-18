class RemoveEarningsColumsnFromOffers < ActiveRecord::Migration
  def self.up
		remove_column :offers, :earnings_min
		remove_column :offers, :earnings_max
		change_column :offers, :etat, :bool, :default => false
  end

  def self.down
  end
end
