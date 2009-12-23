module AchievementsHelper
	
	def data_range(achievement)
		format = achievement.type_id == A_SCHOOL ? :school : :simple
		from = l(achievement.from, :format => format)
		
		if achievement.to < achievement.from || achievement.to >= Date.current
			to = "aktualnie"
		else
			to = l(achievement.to, :format => format) 
		end
		
		"#{from} - #{to}"
	end
	
end
