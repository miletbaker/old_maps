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
  
  has_many :site_maps
  has_many :sites, :through => :site_maps
  
  has_attached_file :map, :styles => { :social => "512x512>", :featured => "300x200#", :thumb => "150x100#" }

  after_save :generate_tiles!

	def to_param
		"#{year}"
	end

  # def site_ids=(site_ids)
  #   site_maps.each do |site_map|
  #     #convert db value to str when comparing with site_ids which is array of strings ["1","2","3"]
  #     site_map.destroy unless site_ids.include? site_map.site_id.to_s
  #   end
  # 
  #   site_ids.each do |site_id|
  #     #convert site_id to int when compare against db value which are already int
  #     site_maps.create(:site_id => site_id) unless site_maps.any? { |sm| sm.site_id == site_id.to_i }
  #   end
  # end

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
    if map_updated_at_changed?
      args = { :rails_env => Rails.env, :map_id => self.id }.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
      system "/usr/bin/rake generate_tiles #{args.join(' ')} --trace 2>&1 >> #{Rails.root}/log/rake.log &"
    end
  end

end
