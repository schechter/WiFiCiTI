class HotspotsController < ApplicationController

  def get_sample_hotspots  # sample data to test on.  needa function to select the correct hotspots based on proximity
    hs_array = Hotspot.all[0...5]
    hs_array
  end

  def get_addresses_from_hs_array(hs_array) #takes an array of hotspots and returns and array of arrays of lat&long
    addresses = []
    hs_array.each do |hs|
      addresses << [hs.latitude, hs.longitude]
    end
    addresses  #returns any [array of [arrays containing lat and long BigDecimal numbers]]
  end

  def address_to_marker_generator(addresses) # takes in an array of arrays of lat and long.
    markers = ''
    addresses.each do |lat, long|
      markers += "|" + lat.to_s + "," + long.to_s
    end
    markers  #returns a string of locations, each one starting with a pipe (|) latitude (,) longitude  -no need to be longer than 6 digits after decimal
  end
  #commented out this version of the method.  If we want to be able to change the size or icon this one will be more useful.  otherwise use smaller version below
  # def hot_spots_map(markers, map_size = '480x480', map_icon = 'http://goo.gl/3KRsr')
  #   url = ''
  #   print "map size +++++++++++++"
  #   p map_size
  #   begining_url_section = 'http://maps.googleapis.com/maps/api/staticmap?'  #map type that will center on given markers
  #   map_size_url_section = "size=#{map_size}&"  #duh
  #   map_icon_url_section = "markers=icon:#{map_icon}"  #links to minified url of goodle drive icon
  #   end_url_section = '&sensor=false'
  #   url += begining_url_section + map_size_url_section + map_icon_url_section + markers + end_url_section
  #   url
  # end

  def hot_spots_map(markers)
    url = ''
    begining_url_section = 'http://maps.googleapis.com/maps/api/staticmap?size=480x480&markers=icon:http://goo.gl/3KRsr'
    end_url_section = '&sensor=false'
    url = begining_url_section + markers + end_url_section
  end

  def index
    @hotspots = Hotspot.order('name ASC')
  end

  def show
    @hotspot = Hotspot.find(params[:id])
    @ratings = @hotspot.ratings
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

  def hs_near_user
    hotspots = Hotspot.near(User.all[1...6].first.location,0.185)  #just using dumby user for now.  need to pass in the user here
    @map_url = hot_spots_map(address_to_marker_generator(get_addresses_from_hs_array(hotspots)))
  end

end
