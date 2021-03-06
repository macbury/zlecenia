class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :index, :profile, :need_account, :expire]
	
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
		saved = @user.update_attributes(params[:user])

		respond_to do |format|
			format.html do
				if saved
					flash[:notice] = "Zapisano zmiany w profilu"
					redirect_to(root_url)
				else
					render(:action => 'edit') 
				end
			end
			format.plain do
				attribute, value = params[:user].to_a.first
				
				if @user.respond_to?("#{attribute}_s".to_sym)
					value = @user.send("#{attribute}_s".to_sym)
				else
					value = @user.send(attribute.to_sym)
				end
				
				if saved
					render :text => value
				else
					render :text => @user.errors.full_messages.join("\n"), :status => :unprocessable_entity
				end
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
		@user = User.find_by_permalink!(params[:id], :include => [:tags] )
		
		unless logged_in? && (self.current_user.pracodawca? || self.current_user == @user)
			redirect_to root_path
		end
		
		@grouped_achievements = @user.achievements.all(:order => "type_id ASC, achievements.from DESC").group_by { |achievement| achievement.type_id }
		
		unless @user.valid?
			flash[:error] = "Brak danych w profilu"
			redirect_to logged_in? ? settings_path : root_path
		end
		
		#respond_to do |format|
		#	format.html
		#	format.xfbml
		#end
	end

end
