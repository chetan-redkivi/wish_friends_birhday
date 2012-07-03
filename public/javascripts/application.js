// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//$(document).ready( function() {
//  $('#deletesuccess').fadeOut(1000);

//});
 window.onload = codeAddress;
 function codeAddress() {
			$.ajax({
				type: 'GET',
				url: '/home/index',
				data: 'offset_val='+(new Date()).getTimezoneOffset(),
				success: function(msg) {
						countdown(year,month,day,hour,minute)
				}
			});
			 return false;
}
