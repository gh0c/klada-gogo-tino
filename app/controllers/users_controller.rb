class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  
  before_action :admin_user,     only: [:destroy, :edit_admin_role, 
                                        :update_admin_role]
  
  before_action :admin_or_correct_user,   only: [:edit, :update]
  
  #before_action :correct_user,   only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the kladara!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def edit_admin_role
    @user = User.find(params[:id])
  end
  
  def update_admin_role
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Admin role updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :picture, :admin)
    end
    

 
end