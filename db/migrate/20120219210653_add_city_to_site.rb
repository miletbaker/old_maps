class AddCityToSite < ActiveRecord::Migration
  def change
    add_column :sites, :city, :string
  end
end
