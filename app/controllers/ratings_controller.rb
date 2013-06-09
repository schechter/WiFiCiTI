class RatingsController < ApplicationController

	def new
		@hotspot = Hotspot.find(params[:id])
		@rating = Rating.new
	end

	def create
		rating = Rating.new(params[:rating])
		if rating.save
			redirect_to root_path, success: "You have successfully checked-in and rated #{hotspot.name}"
		else
			render 'new'
		end
	end

end
