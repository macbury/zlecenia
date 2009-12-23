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
	
	$('#achievement_type_id').change(function () {
		var selected = $(this).find(':selected').val();
		var form = $('#new_achievement');
		if (selected == "0") {
			form.find('.date select:not(#achievement_from_1i):not(#achievement_to_1i)').hide();
		}else{
			form.find('.date select').show();
		}
	}).change();
	
	$('#new_achievement').ajaxForm({
		dataType: "script",
		beforeSubmit: function (formData, jqForm, options) { $(jqForm).hide(); $('#new_achievement_loader').show(); return true; },
		success: function () { $('#new_achievement').show(); $('#new_achievement_loader').hide(); },
		resetForm: true
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
		separator: ",",
		delay: 200
	});
	
	// Strona z ofertami
	
	$('#nearest').click(function () {
		if (this.checked) {
			$('#localizations input[type="checkbox"]:not(#nearest)').attr('checked', false);
		}
	});
	
	$('#localizations input[type="checkbox"]:not(#nearest)').click(function () {
		if (this.checked) {
			$('#nearest').attr('checked', false);
		}
	});
});