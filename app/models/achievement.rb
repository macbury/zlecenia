ACHIEVEMENT_TYPES = ["Szkoła", "Szkolenia", "Doświadczenie zawodowe"]
class Achievement < ActiveRecord::Base
	belongs_to :user
	attr_protected :user_id
	
	validates_presence_of :description
	validates_length_of :description, :within => 3..255
end
