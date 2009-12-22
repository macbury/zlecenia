class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully created user session."

			#if self.current_user.facebook?
				#self.current_user.before_connect(self.facebook_session)
				#self.current_user.save
			#end

      redirect_back_or_default
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Zostałeś wylogowany z serwisu"
    redirect_to root_url
  end
end
