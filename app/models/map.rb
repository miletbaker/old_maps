class Map < ActiveRecord::Base

	def thumbnail_path
		"/system/#{slug}/#{slug}-512.jpg"
	end

	def download_path
		"/system/#{slug}/#{slug}-original.jpg"
	end

end
