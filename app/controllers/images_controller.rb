require 'open-uri'
require 'rmagick'

class ImagesController < ApplicationController
  
  def index
    @images = Image.order('id DESC').all
  end
  
  def show
    
    @image = Image.find params[:id]
    
    url = @image.origin
    file = Magick::Image.from_blob open(url).read
    
  end
  
  def new
    @image = Image.new
  end
  
  def create
    
    @image = Image.new params[:image]
    
    if @image.save
      redirect_to @image
    else
      render :new
    end
    
  end
  
end