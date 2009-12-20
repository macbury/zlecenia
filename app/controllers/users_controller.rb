class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :show, :index, :profile, :need_account, :expire]
  
  filter_access_to [:new, :create, :settings]
  filter_access_to [:edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @user = User.find(params[:id]) }
	
	ensure_authenticated_to_facebook :only => :profile
	ensure_application_is_installed_by_facebook_user :only => :profile
													
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
			flash[:notice] = "Zostałeś zarejestrowany w serwisie!"
      redirect_to settings_path
    else
      render :action => 'new'
    end
  end
  
	def settings
		@user = self.current_user
		render :action => "edit"
	end

  def edit

  end
  
  def update
		respond_to do |format|
			if @user.update_attributes(params[:user])
	      flash[:notice] = "Zapisano zmiany w profilu"
	      format.html { redirect_to root_url }
				format.plain { render :text => params[:user][:avatar].nil? ? @user.logo.url(:thumb) : @user.avatar.url(:thumb) }
	    else
	      format.html { render :action => 'edit' }
				format.plain { render :text => params[:user][:avatar].nil? ? @user.logo.url(:thumb) : @user.avatar.url(:thumb) }
	    end
		end
  end
	
	def expire
		clear_fb_cookies!
		clear_facebook_session_information
		reset_session
		
		redirect_to root_path
	end
	
	def need_account
		respond_to do |format|
			format.xfbml
		end
	end
	
	def profile
		user = User.find_by_facebook_uid(facebook_session.user.id)
		if user.nil?
			redirect_to need_account_path
		else
			redirect_to user_path(user.permalink, :format => :xfbml)
		end
		
	end
	
	def show
		@user = User.find_by_permalink!(params[:id])
		if @user.first_name.nil?
			flash[:error] = "Brak danych w profilu"
			redirect_to logged_in? ? settings_path : root_path
		end
		@grouped_tools = @user.tools.group_by { |tool| tool.type_id }
		#@page_keywords += ', ' + @user.tools.map(&:name).join(', ')
		
		respond_to do |format|
			format.html
			format.xfbml
		end
	end
end
