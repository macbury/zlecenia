class AddEndAtToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :end_at, :date
  end

  def self.down
    remove_column :offers, :end_at
  end
end
