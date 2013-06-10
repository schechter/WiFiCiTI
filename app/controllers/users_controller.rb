class UsersController < ApplicationController

  def index
    @users = Users.all
  end

  def create
    user = User.new(params[:user])
    
    if user.save!
      redirect_to #where to go after user creates an account
    else 
      # flash error message to user that create didn't work
      redirect_to new_user_path
    end
  end

  def new
    @user = User.new()
  end

    def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update_atrributes(params[:user])
      redirect_to #where to go after we edit a user
  end
end

  def destroy
    User.find(params[:id]).delete
    redirect_to #where to go after we delete the user
  end
end
