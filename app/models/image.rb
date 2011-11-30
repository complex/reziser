class Image < ActiveRecord::Base
  
  structure do
    origin        :string, validates: [ :presence ]
    size          :string, validates: [ :presence ]
    width         :integer
    height        :integer
    timestamps
  end
  
  after_save :generate, unless: :width_and_height_exist?
  
  def generate
    
    # open image from url
    image = Magick::Image.from_blob(open(origin).read).first
    
    # resize
    image.change_geometry(size){ |width, height, image|
      image.resize! width, height
    }
    
    # save width and height
    self.update_attributes width: image.x_resolution, height: image.y_resolution
    
    # send to s3
    AWS::S3::S3Object.store filename, image.to_blob, Image.bucket, access: :public_read
    
  end
  
  def width_and_height_exist?
    width and height
  end
  
  def filename
    "#{ id }#{ File.extname origin }"
  end
  
  def url
    "http://s3.amazonaws.com/#{ Image.bucket }/#{ filename }"
  end
  
  def self.bucket
    "reziser_#{ Rails.env }"
  end
  
  def self.generate_all
    for image in Image.all do
      image.update_attributes width: nil, height: nil
    end
  end
  
end