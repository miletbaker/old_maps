class PublicController < ApplicationController

	def sitemap
		@maps = Map.order("year").all
	end
end
