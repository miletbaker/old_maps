class MapsController < ApplicationController

  before_filter :check_site

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
	
	def check_site
	  if current_site.nil?
  	  redirect_to Site.first.full_domain
	  end
	end
	
	def load_maps
	  @maps = current_site.maps.order("year ASC").all
	end
end
