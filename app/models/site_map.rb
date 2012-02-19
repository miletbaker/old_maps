class SiteMap < ActiveRecord::Base
  belongs_to :map
  belongs_to :site
end
