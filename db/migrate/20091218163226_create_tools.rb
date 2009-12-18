class CreateTools < ActiveRecord::Migration
  def self.up
    create_table :tools do |t|
      t.integer :user_id
      t.string :name
      t.integer :type_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :tools
  end
end
