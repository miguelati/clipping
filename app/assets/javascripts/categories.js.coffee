$ ->
	$("#filter_by_entity").change (e)->
		location.href = "/categories/?entity=" + $(this).val()
	$("#category_entity_id").change (e)->
		$("#category_parent_id option").remove
		$.ajax 
			url: "/categories/by_entity"
			type: 'POST'
			data: {entity_id: $("#category_entity_id").val()}
			dataType: 'script'
			success: ()->
				#$("#category_parent_id option").remove()
			error: ()->
				alert "Ocurrió un error, por favor recargue la página e intente de nuevo"
			beforeSend: ()->
				$("#category_parent_id option").remove()
				$("#category_parent_id").append($("<option></option>").val("").html("Cargando..."))