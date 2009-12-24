class Contact < ActiveRecord::Base
	def self.columns() @columns ||= []; end

	def self.column(name, sql_type = nil, default = nil, null = true)
		columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
	end

	column :from_id, :integer
	column :to_id, :integer
	column :offer_id, :integer
	column :body, :text
	xss_terminate
	
	belongs_to :author, :class_name => "User", :foreign_key => "from_id"
	belongs_to :recipient, :class_name => "User", :foreign_key => "to_id"
	belongs_to :offer, :class_name => "Offer", :foreign_key => "offer_id"
	
	validates_presence_of :body
	validates_length_of :body, :within => 3..2000
end
