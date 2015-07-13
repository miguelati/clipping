$ ->
	entity_id = ""
	$("#filter_by_entity").change (e)->
		location.href = "/shippings/?entity=" + $(this).val()
	if $(".date_time").length > 0
		$(".date_time").datetimepicker
			weekStart: 1
			autoclose: true
	
	$("#category").bind 'cocoon:before-insert', (e,task_to_be_added)->
		task_to_be_added.fadeIn('slow')
		id = $(e.target).attr("id").replace("category_", "")
		$(task_to_be_added).find("input[type=hidden]:first").val(id)
	
	$("#category").bind 'cocoon:after-insert', (e, task_to_be_added)->
		$(".date_time").datetimepicker()
		$("input.get_url_data").focusout (e)->
			#urlRegex = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/;
			urlData = $(this).val()
			idData = $(this).attr('id')
			#if urlRegex.exec(urlData ) != null
			$.ajax
				url: "/shippings/check_source_url"
				type: "POST"
				data: {url: urlData}
				dataType: "json"
				beforeSend: ()->
					# TODO: agregar el icono de 'cargando'
				success: (data)->
					$("#"+ idData.replace("url", "title")).val(data.title)
					$("#"+ idData.replace("url", "short_content")).val(data.short_content)
					$("#"+ idData.replace("url", "source")).val(data.source)
					$("#"+ idData.replace("url", "source_url")).val(data.source_url)