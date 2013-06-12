class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def find_me
    #@user_location = Geocoder.search(request.remote_ip).first.data
    @user_location = Geocoder.search("207.38.216.253").first.data #TEST IP.. REPLACE WITH ABOVE LINE IN PROD
    if current_user
      @hotspots = Hotspot.find_hs(current_user)
    else
      # NEED TO ADD CODE FOR NON AUTHED USER HERE
    end
  end

  def new
    @user = User.new
  end

  def create
    p 'params, email, id ++++++++_________+=========='
    p params
    p params[:email]

    user = User.new(params[:user])
    if user.save
      redirect_to user
    else
      # flash error message to user that create didn't work
      render 'new'
    end
  end

  def edit
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
