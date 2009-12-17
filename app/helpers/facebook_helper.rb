module FacebookHelper
	def facebook_connect(options = {})
	  options[:controller] ||= "user_sessions"
		options[:text] ||= "Connect with Facebook"
  	
		output = form_tag(options[:controller], :method => :post, :id => 'connect_to_facebook_form', :style => "display: none")
		output << "</form>"
		output << content_tag('fb:login-button', content_tag('fb:intl', options[:text]), :v => 2, :onlogin => "$(function(){ $('#connect_to_facebook_form').submit(); });")
		
		return output
	end
end