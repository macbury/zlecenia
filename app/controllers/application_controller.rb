# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user, :logged_in?, :admin?, :own?, :pracodawca?, :pracownik?
  
  before_filter :staging_authentication, :seo, :user_for_authorization

  protected
	
	def user_for_authorization
		Authorization.current_user = self.current_user
	end
	
	def permission_denied
    flash[:error] = "Nie masz wystarczających uprawnień aby móc odwiedzić tą stronę"
    redirect_to root_url
  end
	
	def seo
		@standard_tags = 'praca IT, zlecenia IT, programista, webdeveloper, grafik, administrator, staż, praktyka, wolontariusz, etat, praca zdalna'
		set_meta_tags :description => 'Oferty pracy dla programistów, webdeveloperów, administratorów oraz grafików',
	                :keywords => @standard_tags
		
	end
	
  def staging_authentication
    if ENV['RAILS_ENV'] == 'staging'
      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == "change this" && password == "and this"
      end
    end
  end

  
  def current_user_session
    @current_user_session ||= UserSession.find
    return @current_user_session
  end
  
  def current_user
    @current_user ||= self.current_user_session && self.current_user_session.user
    return @current_user
  end

  def logged_in?
    !self.current_user.nil?
  end
  
	def wymagany_pracodawca
		redirect_to root_path unless pracodawca?(self.current_user)
	end

	def pracodawca?(user)
		logged_in? && (self.current_user.pracodawca? || self.current_user.id == user.id)
	end

	def pracownik?
		logged_in? && (self.current_user.pracownik?)
	end

  def own?(object)
    logged_in? && self.current_user.own?(object)
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default
    redirect_to session[:return_to] || root_path
    session[:return_to] = nil
  end
  
	def need_enter_profile_information(user=nil)
		if logged_in? && !self.current_user.valid?
			flash[:error] = "Brak danych w profilu"
			redirect_to logged_in? ? settings_path : root_path
		end
	end

  def login_required
    unless logged_in?
      respond_to do |format|
        format.html do
          flash[:error] = "Musisz się zalogować aby móc objrzeć tą strone"
          store_location
          redirect_to login_path
        end
        format.js { render :js => "window.location = #{login_path.inspect};" }
      end

    end
  end
end
