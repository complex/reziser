class ImagesController < ApplicationController
  
  def index
    @images = Image.order('id DESC').where private: false
  end
  
  def show
    @image = Image.find params[:id]
    
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @image.to_json(methods: [ :url, :hash, :filename ]) }
      format.img  { redirect_to @image.url }
    end
    
  end
  
  def new
    
    if params[:origin] and params[:size]
      find_or_create query_params
    else
      @image = Image.new
    end
    
  end
  
  def create
    find_or_create params[:image]
  end
  
  private
  
  def find_or_create params
    
    @image = Image.find_or_create keys_to_symbols(values_to_booleans(params))
    
    respond_to do |format|
      format.html { redirect_to @image }
      format.json { render json: @image.to_json }
      format.img  { redirect_to @image.url }
    end
    
  end
  
end