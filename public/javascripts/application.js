function flash(type, message) {
	$('.wrapper').prepend('<div class="flash flash_'+type+'">'+message+'</div>');
	$('.notice, .error').hover(function () {
		$(this).slideUp();
	});
	setTimeout(function () {
		$('.flash').slideUp();
	}, 5000);
}

$(document).ready(function () {
	// Strona profilu
	$('#new_tool').ajaxForm({
		dataType: "script",
		beforeSubmit: function (formData, jqForm, options) { $(jqForm).hide(); return true },
		success: function () { $('#new_tool').show(); },
		clearForm: true
	});
	
	$('#file_upload').ajaxForm({
		dataType: "json",
		clearForm: true,
		complete: function(XMLHttpRequest, textStatus) {
			$('#file_upload img').attr('src', XMLHttpRequest.responseText);
			$("#file_upload fieldset").show();
			$("#file_upload .loader").hide();
		},
	});
	
	$('#file_upload input').change(function(){ 
		$(this).parent().submit(); 
		$("#file_upload fieldset").hide();
		$("#file_upload .loader").show();
	});
	
	// Dodawanie ofert
	$('#offer_description').markItUp(mySettings, { previewAutoRefresh:false });
	
	$('#offer_tag_list').tagSuggest({
		url: "/offers/suggest_tag",
		tagContainer: "div",
		tagWrap: "div",
		separator: " ",
		delay: 200
	});
});