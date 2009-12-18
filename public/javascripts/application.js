$(document).ready(function () {
	// Strona profilu
	$('#new_tool').submit(function () {
		var form = $(this);
		form.hide();
		$.ajax({
			type: "POST",
			dataType: "script",
			url: form.attr('action'),
			data: form.serialize(),
			complete: function(){
				form.show();
			},
		});

		return false;
	});	
});