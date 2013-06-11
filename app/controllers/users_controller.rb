class UsersController < ApplicationController

  def find_me
    @user = User.new(name: 'guest', location: request.remote_ip)
  end
  
  def index
    @users = User.all
  end

  def create
    user = User.new(params[:user])

    if user.save!
      redirect_to user
    else
      # flash error message to user that create didn't work
      render 'new'
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
    if user.update_attributes(params[:user])
      redirect_to user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).delete
    redirect_to #where to go after we delete the user
  end
end
