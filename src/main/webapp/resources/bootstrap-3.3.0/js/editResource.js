$(function(){
	$('#edit-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var id = $tr.attr('data-id');
		var name = $tr.attr('data-name');
		var permission= $tr.attr('data-permission');
		var url = $tr.attr('data-url');
		var isMenu= $tr.attr('data-isMenu');
		var parentId = $tr.attr('data-parentId');
		var rank = $tr.attr('data-rank');
		$(':input[name="id"]','#edit-modal-form').val(id);
		$(':input[name="name"]','#edit-modal-form').val(name);
		$(':input[name="permission"]','#edit-modal-form').val(permission);
		$(':input[name="url"]','#edit-modal-form').val(url);
		$(':input[name="isMenu"]','#edit-modal-form').val([isMenu]);
		$(':input[name="parentId"]','#edit-modal-form').val(parentId);
		$(':input[name="rank"]','#edit-modal-form').val(rank);
	});
});