class MapsController < ApplicationController

	def index
		load_maps
		@featured_maps = current_site.maps.random(3)
	end

	def show
		if params[:year].present?
			@map = Map.find_by_year(params[:year])
		else
			redirect_to map_path(Map.first)
		end
		redirect_to map_path(Map.first) unless @map
		if params[:embed].present?
		  render 'embed', :layout => false
	  else
		  load_maps
		end
	end
	
	private
	
	def load_maps
	  @maps = current_site.maps.order("year ASC").all
	end
end
