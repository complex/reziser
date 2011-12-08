module ApplicationHelper
  
  def query_params
    request.query_parameters
  end
  
  def reziser_image_tag origin, size, options = {}
    image_tag new_image_path(options.merge(format: :img, origin: origin, size: size))
  end
  
  def keys_to_symbols hash
    
    new_hash = {}
    hash.each do |key, value|
      new_hash[key.to_sym] = value
    end
    
    return new_hash
    
  end
  
  def values_to_booleans hash
    
    new_hash = {}
    hash.each do |key, value|
      if ['true', 'false'].include? value
        new_hash[key] = string_to_boolean(value) 
      else
        new_hash[key] = value
      end
    end
    
    return new_hash
    
  end

  def string_to_boolean string
    if string == 'true'
      true
    elsif string == 'false'
      false
    end
  end
  
end