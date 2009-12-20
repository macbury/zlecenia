OFFER_TYPES = ['Programowanie', 'Administrowanie', 'Wygląd']
ETAT_TYPES = ["zlecenie (konkretna usługa do wykonania)", "poszukiwanie współpracowników / oferta pracy", "wolontariat (praca za reklamy, bannery, itp. lub praca za darmo)", "staż/praktyka"]
ETAT_LABELS = ["zlecenie", "etat", "wolontariat", "praktyka"]
class Offer < ActiveRecord::Base
	belongs_to :user
	belongs_to :place
	
	is_taggable :tags
	xss_terminate
	has_permalink :title
	acts_as_geocodable	:units => :kilometers
	
	validates_presence_of :title, :description, :tag_list
	validates_length_of :title, :within => 3..255
	validates_length_of :description, :within => 10..5000
	validates_inclusion_of :type_id, :in => 0..OFFER_TYPES.size-1
	
	validates_inclusion_of :etat,
			:in => 0..ETAT_TYPES.size - 1
	validates_inclusion_of :dlugosc_trwania,
      :in => 1..60
	
	attr_protected :user_id, :end_at
	
	def typ
		OFFER_TYPES[self.type_id]
	end
	
	def locality
		place.name rescue ""
	end
	
	def dlugosc_trwania
		date = created_at.nil? ? Date.current.to_date : created_at.to_date
		return (read_attribute(:end_at) - date).to_i rescue 14
	end
	
	def dlugosc_trwania=(val)
		date = created_at.nil? ? Date.current.to_date : created_at.to_date
		write_attribute(:end_at, date+val.to_i.days)
	end
	
	def to_param
		permalink
	end
	
end
