class Image < ActiveRecord::Base
  
  structure do
    origin        :string, validates: [ :presence ]
    size          :string, validates: [ :presence ]
    timestamps
  end
  
  def url
    
  end
  
end