ACHIEVEMENT_TYPES = ["Szkoła", "Szkolenia", "Doświadczenie zawodowe"]
A_SCHOOL = 0
A_TRANING = 1
A_EXPERIENCE = 2
class Achievement < ActiveRecord::Base
	xss_terminate
	belongs_to :user
	attr_protected :user_id
	
	validates_presence_of :description
	validates_length_of :description, :within => 3..255
	validates_inclusion_of :type_id, :in => 0..ACHIEVEMENT_TYPES.size-1
	
end
