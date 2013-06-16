class HotspotsController < ApplicationController
  before_filter :admin_auth, except: :show

  def index
    @hotspots = Hotspot.order('name ASC')
  end

  def show
    @hotspot = Hotspot.find(params[:id])
    @ratings = @hotspot.ratings
    @rating = Rating.new
    @google_map_url = Hotspot.url_gen([@hotspot])
    @avg_rating = Rating.calculate_avg_rating(@hotspot.id)
  end

  def new
    @hotspot = Hotspot.new
  end

  def create
    hotspot = Hotspot.new(params[:hotspot])
    if hotspot.save
      redirect_to root_path, success: "Hotspot saved"
    else
      render 'new', fail: 'Failed'
    end
  end

  def map_generator
    @map_url = Hotspot.hs_near_user
  end
end
