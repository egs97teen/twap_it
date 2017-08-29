$(document).ready(function() {
	
	$("#imageUrl").on('input', function() {
		var input = $(this).val();
		if (input == "") {
			$("#imageBox").hide()
		} else {
			var display = "<img src='"+input+"'>";
			$("#imageBox").hide().html(display).fadeIn('slow');
		}
	});
	
	$('#name').one('keydown', function() {
		$('.popup').css( "left", "20px" );
		$('.dots').show().delay(1200).fadeOut(0);
		$('.text').hide().delay(1200).fadeIn(200);
	});
	
	$('#email').one('keydown', function() {
		$('.popup2').css( "right", "20px" );
		$('.dots2').show().delay(1200).fadeOut(0);
		$('.text2').hide().delay(1200).fadeIn(200);
	});
	  
})