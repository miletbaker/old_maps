class Site < ActiveRecord::Base
  
  # t.string   "domain"
  # t.string   "title"
  # t.string   "short_desc"
  # t.string   "long_desc"
  # t.datetime "created_at"
  # t.datetime "updated_at"
  
  has_many :site_maps
  has_many :maps, :through => :site_maps
  
  has_attached_file :logo, :styles => { :large => "960x88>", :title => "400x40>", :medium => "300x25>" }
  
  def full_domain
    "http://www.#{domain}"
  end
  
  def linked_sites
    Site.where("locale = ? and id != ?", locale, id)
  end
  
end
