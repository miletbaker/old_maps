class AddAttachmentMapToMap < ActiveRecord::Migration
  def self.up
    add_column :maps, :map_file_name, :string
    add_column :maps, :map_content_type, :string
    add_column :maps, :map_file_size, :integer
    add_column :maps, :map_updated_at, :datetime
    add_column :maps, :available, :boolean
  end

  def self.down
    remove_column :maps, :map_file_name
    remove_column :maps, :map_content_type
    remove_column :maps, :map_file_size
    remove_column :maps, :map_updated_at
    remove_column :maps, :available
  end
end
