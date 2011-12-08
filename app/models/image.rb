class Image < ActiveRecord::Base
  
  structure do
    origin        :string, validates: [ :presence ]
    size          :string, validates: [ :presence ]
    width         :integer
    height        :integer
    private       :boolean, default: false
    crop          :boolean, default: false
    timestamps
  end
  
  before_save :generate
  after_destroy :remove
  
  def generate
    
    blob = open(origin).read
    image = Magick::Image.from_blob(blob).first
    
    if crop
      
      base_size = size.gsub(/\W/, '').split('x')
      width = base_size.first.to_i
      height = base_size.second.to_i
      
      image.resize_to_fill! width, height
      
    else
    
      image.change_geometry(size){ |width, height, image|
        image.resize! width, height
      }
      
    end
    
    self.width = image.columns
    self.height = image.rows
    
    AWS::S3::S3Object.store filename, image.to_blob, Image.bucket, access: :public_read
    
  end
  
  def remove
    AWS::S3::S3Object.delete filename, Image.bucket
  end
  
  def hash
    Digest::SHA1.hexdigest "#{ origin }#{ width }#{ height }"
  end
  
  def filename
    "#{ hash }#{ File.extname origin }"
  end
  
  def url
    "http://s3.amazonaws.com/#{ Image.bucket }/#{ filename }"
  end
  
  def self.find_or_create params
    
    search_params = { crop: false }.merge! params
    search_params.select!{ |key, value|
      [ :origin, :size, :crop ].include? key.to_sym
    }
    
    existing = Image.where(search_params).first
    image = Image.new(params)
    
    if existing
      existing
    elsif image.save
      image
    else  
      false
    end
    
  end
  
  def self.bucket
    "reziser_#{ Rails.env }"
  end
  
  def self.generate_all
    for image in Image.all do
      image.generate
    end
  end
  
end