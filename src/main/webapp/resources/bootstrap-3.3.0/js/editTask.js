$(function(){
	$('#edit-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var id = $tr.attr('data-id');
		var title = $tr.attr('data-title');
		var description = $tr.attr('data-description');
		$(':input[name="id"]','#edit-modal-form').val(id);
		$(':input[name="title"]','#edit-modal-form').val(title);
		$(':input[name="description"]','#edit-modal-form').val(description);
	});
});