OFFER_TYPES = ['Programowanie', 'Administrowanie', 'Wygląd']

class Offer < ActiveRecord::Base
	belongs_to :user
	xss_terminate
	has_permalink :title, :update => true
	
	validates_presence_of :title, :description
	validates_length_of :title, :within => 3..255
	validates_length_of :description, :within => 10..5000
	validates_inclusion_of :type_id, :in => 0..OFFER_TYPES.size-1
	
	attr_protected :user_id
	
	def typ
		OFFER_TYPES[self.type_id]
	end
	
	def to_param
		permalink
	end
	
end
