class Map < ActiveRecord::Base

	def to_param
		"#{year}"
	end

	def thumbnail_path
		"/system/#{slug}/#{slug}-thumb.jpg"
	end

	def download_path
		"/system/#{slug}/#{slug}-original.jpg"
	end

	def thumbnail_from_root
		"system/#{slug}/#{slug}-thumb.jpg"
	end

end
