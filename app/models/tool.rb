TOOL_TYPES = ['Framework', 'Plugin', 'Biblioteka', 'Program', 'System Operacyjny', 'Język programowania', 'Baza danych', 'System kontroli wersji']

class Tool < ActiveRecord::Base
	xss_terminate
	validates_presence_of :name
	validates_length_of :name, :within => 3..50
	belongs_to :user
	
	validates_inclusion_of :type_id, :in => 0..TOOL_TYPES.size-1
	attr_protected :user_id
	
	def typ
		TOOL_TYPES[self.type_id]
	end
end
