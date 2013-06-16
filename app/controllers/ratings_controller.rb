class RatingsController < ApplicationController

	def index
		@ratings = Rating.all
	end

	def new
		@hotspot = Hotspot.find(params[:id]) 
		@rating = Rating.new
	end

	def create
		@rating = Rating.new(params[:rating])
		@hotspot = Hotspot.find(params[:rating][:hotspot_id])
		if @rating.save
			flash[:success] = "You have successfully checked-in and rated #{@hotspot.name}"
			redirect_to @hotspot
		else
			flash[:fail] = "There was an error rating #{@hotspot.name}"
			redirect_to @hotspot
		end
	end

	def show
		@rating = Rating.find(params[:id]) #should be ratings for one hotspot, not rating id.
	end
end