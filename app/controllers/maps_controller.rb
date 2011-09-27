class MapsController < ApplicationController

	def index
		redirect_to map_path(Map.first)
	end

	def show
		if params[:year].present?
			@map = Map.find_by_year(params[:year])
		else
			redirect_to map_path(Map.first)
		end
		render_404 and return unless @map
		@maps = Map.order("year ASC").all unless params[:embed].present?
	end
end
