class UsersController < ApplicationController
  before_filter :admin_auth, only: [:index, :destroy]
  
  def index  #just for admin
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def find_me
    if params[:location]
      @hotspots = Hotspot.near(params[:location], 0.3)
      puts '+++++++++++++++++++++++++++'
      puts '+++++++++++++++++++++++++++'
      puts @hotspots
    else
      user_location = Geocoder.search('208.185.23.206')
      location = user_location.first.data
      lat = location['latitude'].to_s
      long = location['longitude'].to_s
      puts '+++++++++++++++++++++++++++' 
      @hotspots = Hotspot.near([lat,long],0.3)
      puts '+++++++++++++++++++++++++++'
      puts @hotspots
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
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Account has been sucessfully updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).delete
    flash[:success] = "Account has been sucessfully removed"
    redirect_to root_path
  end
end
