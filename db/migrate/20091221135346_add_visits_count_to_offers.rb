class AddVisitsCountToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :visits_count, :integer, :default => 0
  end

  def self.down
    remove_column :offers, :visits_count
  end
end
