class Map < ActiveRecord::Base

  # t.string   "title"
  # t.string   "slug"
  # t.text     "description"
  # t.integer  "year"
  # t.integer  "min_zoom",    :default => 0
  # t.integer  "max_zoom"
  # t.integer  "init_zoom",   :default => 1
  # t.datetime "created_at"
  # t.datetime "updated_at"
  # t.integer  "sites_id"
  
  belongs_to :site
  has_attached_file :map, :styles => { :social => "512x512>", :featured => "#300x200", :thumb => "#150x100" }

  after_post_process :generate_tiles!

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
	
	def featured_path
	 "/system/#{slug}/#{slug}-thumb.jpg"
	end

  def generate_tiles!
    args = { :rails_env => Rails.env, :map_id => self.id }.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
    system "/usr/bin/rake generate_tiles #{args.join(' ')} --trace 2>&1 >> #{Rails.root}/log/rake.log &"
  end

end
