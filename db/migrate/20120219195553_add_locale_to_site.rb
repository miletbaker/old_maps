class AddLocaleToSite < ActiveRecord::Migration
  def change
    add_column :sites, :locale, :string, :default => "en"
  end
end
