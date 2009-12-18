class ToolsController < ApplicationController
	before_filter :login_required
	filter_resource_access
	
  def create
		@tool.user = self.current_user
		
		respond_to do |format|
	    if @tool.save
	      flash[:notice] = "Nardzędzie zostało dodane"
	      format.html { redirect_to edit_user_path(self.current_user) }
				format.js
	    else
	      format.html { render :action => 'new' }
				format.js
	    end
		end
  end
  
  def destroy
    @tool.destroy
    flash[:notice] = "Narzędzie zostało usunięte!"
    redirect_to edit_user_path(self.current_user)
  end
end
