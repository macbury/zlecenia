class AchievementsController < ApplicationController
	before_filter :login_required
	filter_resource_access
	
  def create
		@achievement.user = self.current_user
		
		if @achievement.save
      flash[:notice] = "Osiągnięcie dodane"
    else
			flash[:error] = "Nie można dodać osiągnięcia: " + @achievement.errors.full_messages.join(',')
    end

		respond_to do |format|
			format.html { redirect_to settings_path }
			format.js
		end
  end
  
  def destroy
    @achievement.destroy
    flash[:notice] = "Narzędzie zostało usunięte!"
    redirect_to edit_user_path(self.current_user)
  end
end
