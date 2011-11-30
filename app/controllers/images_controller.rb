require 'aws/s3'

class ImagesController < ApplicationController
  
  def index
    @images = Image.order('id DESC').all
  end
  
  def show
    
    @image = Image.find params[:id]
    
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