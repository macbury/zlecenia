class AddPricesToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :price_from, :integer
    add_column :offers, :price_to, :integer
  end

  def self.down
    remove_column :offers, :price_to
    remove_column :offers, :price_from
  end
end
