$(function(){
	$('#edit-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var id = $tr.attr('data-id');
		var name = $tr.attr('data-name');
		var sn= $tr.attr('data-sn');
		$(':input[name="id"]','#edit-modal-form').val(id);
		$(':input[name="name"]','#edit-modal-form').val(name);
		$(':input[name="sn"]','#edit-modal-form').val(sn);
	});
});