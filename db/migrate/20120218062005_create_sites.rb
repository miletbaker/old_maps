class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string  :domain
      t.string  :title
      t.string  :short_desc
      t.string  :long_desc
      t.timestamps
    end
    
  end
end
