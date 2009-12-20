class ToolsController < ApplicationController
	before_filter :login_required
	filter_resource_access
	
  def create
		@tool.user = self.current_user
		
		if @tool.save
      flash[:notice] = "Nardzędzie zostało dodane"
    else
			flash[:error] = "Nie można dodać narzędzia: " + @tool.errors.on(:name).join(',')
    end

		respond_to do |format|
			format.html { redirect_to ustawienia_path }
			format.js
		end
  end
  
  def destroy
    @tool.destroy
    flash[:notice] = "Narzędzie zostało usunięte!"
    redirect_to edit_user_path(self.current_user)
  end
end
