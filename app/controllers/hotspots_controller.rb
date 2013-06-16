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
    #we need the geocoder before saving for long & lat
    if hotspot.save
      redirect_to root_path, success: "Hotspot saved"
    else
      render 'new', fail: 'Failed'
    end
  end

  def edit
    @hotspot = Hotspot.find(params[:id])
  end

  def update
    hotspot = Hotspot.find(params[:id])
    #we need the geocoder before updating for long & lat
    if hotspot.update_attributes(params[:hotspot])
      redirect_to root_path, success: "Update successful"
    else
      render 'edit', fail: 'Failed'
    end
  end

  def destroy
    hotspot = Hotspot.find(params[:id])
    hotspot.delete
    redirect_to root_path
  end

  def seed
    data_response = HTTParty.get('https://nycopendata.socrata.com/api/views/ehc4-fktp/rows.json?accessType=DOWNLOAD')
    json = JSON.parse(data_response.body)
    records = json['data']
    records.each do |record|

      Hotspot.create(
        name: record[10],
        street: record[12],
        city: record[13],
        zip: record[14],
        phone: record[15],
        fee: record[16],
        url: record[17],
        latitude: record[9][1],
      longitude: record[9][2])

    end
    redirect_to root_path, success: 'The Database has been successfully updated'
  end

  def map_generator
    @map_url = Hotspot.hs_near_user

  end
end
