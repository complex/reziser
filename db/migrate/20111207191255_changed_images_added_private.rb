class ChangedImagesAddedPrivate < ActiveRecord::Migration
  def self.up
    add_column :images, :private, :boolean, :default=>false
  end
  
  def self.down
    remove_column :images, :private
  end
end
