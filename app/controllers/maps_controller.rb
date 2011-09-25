class MapsController < ApplicationController

	def index
		if params[:year].present?
			@map = Map.find_by_year(params[:year])
		else
			@map = Map.first
		end
		render_404 and return unless @map
		@maps = Map.order("year ASC").all unless params[:embed].present?
	end
end
