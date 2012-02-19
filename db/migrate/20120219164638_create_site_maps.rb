class CreateSiteMaps < ActiveRecord::Migration
  def change
    create_table :site_maps do |t|
      t.references :site
      t.references :map
      t.timestamps
    end
    
    add_index :site_maps, :site_id
    add_index :site_maps, :map_id
    
    SiteMap.reset_column_information
    
    s = Site.new
    s.domain = "oldmapsofparis.com"
    s.title = "Old Maps of Paris"
    s.maps = Map.all
    s.save
  end
end
