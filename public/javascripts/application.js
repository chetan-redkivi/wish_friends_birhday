// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//$(document).ready( function() {
//  $('#deletesuccess').fadeOut(1000);

//});

$(document).ready( function() {
	$(window).load(function() {
			$.ajax({
				type: 'GET',
				url: '/',
				data: 'offset_val='+(new Date()).getTimezoneOffset(),
				success: function(msg) {
				}
			});
			 return false;

	});
});
