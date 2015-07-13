$ ->
	$("#filter_by_entity").change (e)->
		location.href = "/receivers/?entity=" + $(this).val()