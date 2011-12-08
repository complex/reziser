class ChangedImagesAddedCrop < ActiveRecord::Migration
  def self.up
    add_column :images, :crop, :boolean, :default=>false
  end
  
  def self.down
    remove_column :images, :crop
  end
end
