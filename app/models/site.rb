class Site < ActiveRecord::Base
  
  # t.string   "domain"
  # t.string   "title"
  # t.string   "short_desc"
  # t.string   "long_desc"
  # t.datetime "created_at"
  # t.datetime "updated_at"
  
  has_many :maps
  
end
