class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.integer :offer_id
      t.integer :ip_address

      t.timestamps
    end
  end

  def self.down
    drop_table :visits
  end
end
