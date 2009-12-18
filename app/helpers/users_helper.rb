module UsersHelper
	
	def login_for(user)
		if user.pracownik?
			link_to user.full_name, user_path(user.permalink)
		else
			content_tag :b, user.company || user.email
		end
	end
	
	def avatar_for(user, size=:normal)
		if user.facebook?
			content_tag 'fb:profile-pic', '', :size => size.to_s, :linked => "false", :uid => user.facebook_uid
		else
			image_tag(user.avatar.url(size))
		end
	end
	
end
