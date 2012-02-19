require 'rmagick'
require 'fileutils'
desc "Generate Tiles"
task :generate_tiles => :environment do
  map = Map.find(ENV['MAP_ID'])
  
  # setup - get filename (without extension and directory)
  img_name = File.basename(map.map.path, ".jpg")
  dir = File.expand_path(File.join(File.dirname(map.map.path), ".."))
  
  Rails.logger.info "Processing Tiles for #{img_name}"
  
  # Load the source image and a little information
  img = Magick::Image.read(map.map.path).first
  w = img.columns
	h = img.rows
  
  FileUtils.rm_rf("#{dir}/tiles") if File::directory?("#{dir}/tiles")
  Dir.mkdir("#{dir}/tiles")
  
  # Find the next largest multiple of 256 and the power of 2
  dim = w > h ? w : h
  pow = -1
  
  loop do
    i = 256*(2**pow+=1)
    next if i < dim
    dim = i
    break
  end
  
  # Resize the source image up to the larger size
  if (dim > w && dim > h)
  	puts "Resizing image to #{dim}px"
    # Determine the optimal pixel radius for sharpening

    img.change_geometry!("#{dim}x#{dim}") { |cols, rows, i|
 		 i.resize!(cols, rows)
 	  }
        sharp = ( w/dim > h/dim ? dim/w : dim/h )/2
    img = img.sharpen(sharp)
  end
  
  # Build a new square image with a black background, and composite the source image on top of it.
  master = Magick::Image.new(dim,dim){ self.background_color = "#E4E3DF" }
  master.composite!(img, Magick::CenterGravity, Magick::OverCompositeOp)
  
  img = nil

  # Create slice layers
  layer = 0
  loop do
    # Google Maps only allows 19 layers (though I doubt we'll ever reach this point).
    break if layer > 18
    width = 256*(2**layer)

    break if width > dim
    Dir.mkdir("#{dir}/tiles/#{layer}", 0775) unless File::directory?("#{dir}/tiles/#{layer}")

    crop_master = master.clone
    #crop_master = crop_master.blur_image((dim/width)/ 2)
    crop_master.resize!(width, width)
    #crop_master = crop_master.blur_image(0.7)

    max_loop = (width / 256) - 1

    (0 .. max_loop).each do |x|
      (0 .. max_loop).each do |y|
        crop = crop_master.clone
        crop.crop!( x*256, crop_master.rows - ((y + 1) * 256), 256, 256) 
        crop.write("#{dir}/tiles/#{layer}/#{x}-#{y}.jpg")
        crop = nil
      end
    end
    
    layer+=1
    crop_master = nil
  end
  map.max_zoom = layer-1
  map.init_zoom = layer >= 3 ? 3 : layer
  map.save
  master = nil
  Rails.logger.info "Finished generating #{layer} layers of tiles for #{img_name}"
  
  Notifier.map_processed(map).deliver
end