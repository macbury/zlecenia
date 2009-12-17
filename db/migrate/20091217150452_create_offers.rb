class CreateOffers < ActiveRecord::Migration
  def self.up
    create_table :offers do |t|
      t.integer :type_id
      t.integer :category_id
      t.string :title
      t.string :permalink
      t.integer :user_id
      t.integer :place_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :offers
  end
end
