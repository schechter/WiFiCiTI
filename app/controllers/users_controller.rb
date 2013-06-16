class UsersController < ApplicationController
  before_filter :admin_auth, only: [:index, :destroy]
  
  def index  #just for admin
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @ratings = @user.ratings
  end

  def find_me
    if params[:location]
      @address = params[:location]
      @hotspots = Hotspot.find_by_address(params[:location])
    else
      @address = Geocoder.search([Geocoder.search('208.185.23.206').first.data['latitude'].to_s,Geocoder.search('208.185.23.206').first.data['longitude'].to_s]).first.data['formatted_address']
      @hotspots = Hotspot.find_by_ip_address
    end
    @google_map_url = Hotspot.url_gen(@hotspots)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Thanks for creating an account with WiFiCiTi!'
      redirect_to root_path
    else
      flash[:fail] = 'There was an error creating your account.  Please try again'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = 'Account has been sucessfully updated'
      redirect_to root_path
    else
      flash[:fail] = 'There was an error updating your account.'
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).delete
    flash[:success] = 'Account has been sucessfully removed'
    redirect_to root_path
  end
end
