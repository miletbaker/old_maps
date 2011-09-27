// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require maps

$(function(){
	$('#map_selector').change(function(){
		window.location = "/map/" + this.value;
	});

	$('#embed').fancybox({
		content: $('#popup-embed'),
		onComplete: function(){
			$('#embed-code').val('<iframe src="' + 'http://' + window.location.host + '/map/' + map_year + '?embed=true&zoom=' + map.getZoom() + '&lat=' + escape(map.getCenter().lat()) + "&lon=" + escape(map.getCenter().lng()) + '" width="560px" height="318px" frameborder="0"></iframe><br/><a href="' + 'http://' + window.location.host + '/map/' + map_year + '?zoom=' + map.getZoom() + '&lat=' + escape(map.getCenter().lat()) + "&lon=" + escape(map.getCenter().lng()) + '" title="View Larger Map">View Larger Map</a>');
		}
	});

	$('#download').click(function(){
		window.location = "/system/" + map_loc + "/" + map_loc + "-original.jpg"
	});

	$('#embed-code').click(function(){
		this.select();
	});

	loadMap();
});
	