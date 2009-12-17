class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :show, :index]
  
  filter_access_to [:new, :create]
  filter_access_to [:edit, :destroy, :update], :attribute_check => true,
                          :load_method => lambda { @user = User.find(params[:id]) }
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
			flash[:notice] = "Zostałeś zarejestrowany w serwisie!"
      redirect_to edit_user_path(@user)
    else
      render :action => 'new'
    end
  end
  
  def edit

  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end

	def show
		@user = User.find_by_permalink!(params[:id])

	end
end
