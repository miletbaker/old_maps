class Site < ActiveRecord::Base
  
  # t.string   "domain"
  # t.string   "title"
  # t.string   "short_desc"
  # t.string   "long_desc"
  # t.datetime "created_at"
  # t.datetime "updated_at"
  
  has_many :site_maps
  has_many :maps, :through => :site_maps
  
  def full_domain
    "http://www.#{domain}"
  end
  
  def linked_sites
    Site.where("locale = ? and id != ?", locale, id)
  end
  
end
