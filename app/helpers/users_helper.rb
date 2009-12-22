module UsersHelper
	
	def login_for(user)
		if user.pracownik?
			link_to user.full_name, user_path(user.permalink)
		else
			content_tag :b, user.full_name
		end
	end
	
	def avatar_for(user, size=:normal)
		if user.facebook?
			content_tag 'fb:profile-pic', '', :size => size.to_s, :linked => "false", :uid => user.facebook_uid
		else
			image_tag(user.avatar.url(size))
		end
	end
	
	def render_attribute_for(model, attribute, name, type=:text)
		out = ""
		out += content_tag :dt, name
		
		if model.respond_to?("#{attribute}_s")
			val = model.send("#{attribute}_s")
		else
			val = model.send(attribute)
		end
		
		val = text_field_tag "test", val
		
		out += content_tag :dd, val, :class => type.to_s, :name => "#{model.class.to_s.downcase}[#{attribute.to_s}]"
		
		out
	end
	
end
