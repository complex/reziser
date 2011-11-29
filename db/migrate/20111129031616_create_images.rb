class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :origin 
      t.string :size 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
  end
  
  def self.down
    drop_table :images
  end
end
