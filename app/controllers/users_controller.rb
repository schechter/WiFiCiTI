class UsersController < ApplicationController
  before_filter :admin_auth, only: [:index, :destroy]
  
  def index  #just for admin
    @users = User.all
  end

  def show  #users account page
    @user = User.find(params[:id])
  end

  def find_me
    if params[:location]
      @hotspots = Hotspot.near(params[:location], 0.2)
    else
      user_location = Geocoder.search('208.185.23.206')
      location = user_location.first.data
      lat = location['latitude'].to_s
      long = location['longitude'].to_s 
      @hotspots = Hotspot.near([lat,long],0.55) 
    end
    @google_map_url = Hotspot.url_gen(@hotspots)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to new_session_path(email: user.email, password: user.password)
    else
      render :new
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
