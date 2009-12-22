class CreateAchievements < ActiveRecord::Migration
  def self.up
    create_table :achievements do |t|
      t.integer :type_id, :default => 0
			t.integer :user_id
      t.string :description
      t.date :from
      t.date :to
      t.timestamps
    end
  end
  
  def self.down
    drop_table :achievements
  end
end
