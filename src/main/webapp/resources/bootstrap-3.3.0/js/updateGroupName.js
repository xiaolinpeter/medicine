$(function(){
	$('#edit-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var groupName = $tr.attr('data-name');
		var groupId = $tr.attr('data-id');
		$(':input[name="groupName"]','#edit-modal-form').val(groupName);
		$(':input[name="groupId"]','#edit-modal-form').val(groupId);
	});
});