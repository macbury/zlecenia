module UsersHelper
	
	def login_for(user)
		if user.pracownik?
			link_to user.full_name, user_path(user.permalink)
		else
			link_to user.company || user.email, user_path(user.permalink)
		end
	end
	
end
