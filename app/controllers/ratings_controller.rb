class RatingsController < ApplicationController

	def index
		@ratings = Rating.all
	end

	def new
		@hotspot = Hotspot.find(11800)        #(params[:id])  needs to be replaced by actual hs.
		@rating = Rating.new
	end

	def create
		@rating = Rating.new(params[:rating])
		@hotspot = Hotspot.find(11800)        #(params[:id])`
		if @rating.save
			redirect_to root_path, success: "You have successfully checked-in and rated #{hotspot.name}"
		else
			render 'new'
		end
	end

	def show
		@rating = Rating.find(params[:id]) #should be ratings for one hotspot, not rating id.
	end

end
