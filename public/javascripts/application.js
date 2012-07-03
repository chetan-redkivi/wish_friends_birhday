// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//$(document).ready( function() {
//  $('#deletesuccess').fadeOut(1000);

//});

$(document).ready( function() {
	$(window).load(function() {
			var date = new Date();
			var offset = date.getTimezoneOffset();
			$.ajax({
				type: 'GET',
				url: '/home/timezone',
				data: 'offset_val='+offset,
				success: function(msg) {
				}
			});
			 return false;

	});
});
