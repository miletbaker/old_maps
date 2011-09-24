class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string		:title
      t.string		:slug
      t.text		:description
	  t.integer		:year
	  t.integer		:min_zoom, :default => 0
	  t.integer		:max_zoom
      t.integer		:init_zoom, :default => 1
      t.timestamps
    end
  end
end
