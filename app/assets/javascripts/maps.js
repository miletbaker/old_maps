$(function(){
	var map

	$('#map_selector').change(function(){
		window.location = "/" + this.value;
	});

	$('#embed').fancybox({
		content: $('#popup-embed'),
		onComplete: function(){
			$('#embed-code').val('<iframe src="' + window.location + '?embed=' + map.getZoom() + '&lat=' + escape(map.getCenter().lat()) + "&lon=" + escape(map.getCenter().lng()) + '" width="560px" height="318px" frameborder="0"></iframe>');
		}
	});

	$('#download').click(function(){
		window.location = "/system/" + map_loc + "/" + map_loc + "-original.jpg"
	});

	$('#embed-code').click(function(){
		this.select();
	});

	var maptiler = new google.maps.ImageMapType({ 
	  getTileUrl: function(coord, zoom) { 
	  	if (coord.x < 0 || (Math.pow(2,zoom)-coord.y-1) < 0 || (Math.pow(2,zoom)-coord.y-1) >= Math.pow(2,zoom) || coord.x >= Math.pow(2,zoom))
	  		return "/system/blank.jpg";
	  	else
			return "/system/" + map_loc + "/" + zoom + "/" + coord.x + "-" + (Math.pow(2,zoom)-coord.y-1) + ".jpg";  
		}, 
	  tileSize: new google.maps.Size(256, 256), 
	  maxZoom: map_max_zoom,
	  minZoom: map_min_zoom,
	  name:'Paris'
	});

	map = new google.maps.Map(document.getElementById("map"), {streetViewControl: false, mapTypeControl: false}); 
	map.mapTypes.set('paris', maptiler);
	map.setMapTypeId('paris');
	map.setCenter(new google.maps.LatLng(0, 0)); 
	map.setZoom(map_init_zoom);
})