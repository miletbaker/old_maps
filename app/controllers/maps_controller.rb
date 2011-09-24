class MapsController < ApplicationController

	def index
		@maps = Map.all
		if params[:year].present?
			@map = Map.find_by_year(params[:year])
		else
			@map = Map.first
		end
	end
end
