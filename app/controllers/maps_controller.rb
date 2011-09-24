class MapsController < ApplicationController

	def index
		if params[:year].present?
			@map = Map.find_by_year(params[:year])
		else
			@map = Map.first
		end
	end
end
