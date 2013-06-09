module GoogleMapGen
  def get_sample_hotspots  # sample data to test on.  needa function to select the correct hotspots based on proximity
    hs_array = Hotspot.all[0...5]
    hs_array
  end

  def get_addresses_from_hs_array(hs_array) #takes an array of hotspots and returns and array of arrays of lat&long
    addresses = []
    hs_array.each do |hs|
      location =[]
      location << hs.latitude
      location << hs.longitude
      addresses << loction
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

  def hot_spots_map(markers, map_size = '480X480', map_icon = 'http://goo.gl/3KRsr')
    url = ''
    begining_url_section = 'http://maps.googleapis.com/maps/api/staticmap?'  #map type that will center on given markers
    map_size_url_section = 'size=#{map_size}&'   #duh
    map_icon_url_section = 'markers=icon:#{map_icon}'  #links to minified url of goodle drive icon
    end_url_section = '&sensor=false'
    url += begining_url_section + map_size_url_section + map_icon_url_section + markers + end_url_section
    url
  end
end
