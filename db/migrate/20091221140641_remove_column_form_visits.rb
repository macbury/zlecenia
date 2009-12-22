class RemoveColumnFormVisits < ActiveRecord::Migration
  def self.up
		remove_column :visits, :ip_address
		add_column :visits, :ip, :integer
		
		Visit.all.each(&:destroy)
  end

  def self.down
  end
end
