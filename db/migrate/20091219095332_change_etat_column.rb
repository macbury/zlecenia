class ChangeEtatColumn < ActiveRecord::Migration
  def self.up
		remove_column :offers, :etat
		add_column :offers, :etat, :integer, :default => 0
  end

  def self.down
  end
end
