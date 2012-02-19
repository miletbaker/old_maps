class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string  :domain
      t.string  :title
      t.string  :short_desc
      t.string  :long_desc
      t.timestamps
    end
    
    add_column :maps, :site_id, :integer
    add_index :maps, :site_id
    
    Site.reset_column_information
    
    s = Site.new
    s.domain = "oldmapsofparis.com"
    s.title = "Old Maps of Paris"
    s.save
    
    Map.reset_column_information
    
    Map.update_all(:site_id => s.id)
    
  end
end
