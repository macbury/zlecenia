class AddZdalnieToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :zdalnie, :bool, :default => false
  end

  def self.down
    remove_column :offers, :zdalnie
  end
end
