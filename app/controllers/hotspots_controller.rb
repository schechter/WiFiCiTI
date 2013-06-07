class HotspotsController < ApplicationController

	def index
		@hotspots = Hotspot.named
	end

	def show
	end

	def new
	end

	def create
	end

	def edit
	end

	def update
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

end