class RatingsController < ApplicationController

  def index
    @ratings = Rating.all
  end

  def new
    @hotspot = Hotspot.find(params[:id])
    @rating = Rating.new
  end

  def create
    p params
    p params[:rating]
    @rating = Rating.new(params[:rating])
    @hotspot = Hotspot.find(params[:rating][:hotspot_id])
    if @rating.save
      redirect_to(@hotspot)     #redirect_to hotspot_path, success: "You have successfully checked-in and rated #{@hotspot.name}"
    else
      render 'new'
    end
  end

  def show
    @rating = Rating.find(params[:id]) #should be ratings for one hotspot, not rating id.
  end

  #def average_ratings([hotspots])
  #come back to this later  use avg method for arrays in ApplicationController
end
