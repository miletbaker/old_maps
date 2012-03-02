class AddLogoToSite < ActiveRecord::Migration
  def change
    add_column :sites, :logo_file_name, :string
    add_column :sites, :logo_file_size, :integer
    add_column :sites, :logo_content_type, :string
    add_column :sites, :logo_updated_at, :datetime
  end
end
