$(function(){
	$('#submitDetail-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		/*var submitUserId = $tr.attr('data-submitUserId');*/
		var submitUserName = $tr.attr('data-submitUserName');
		var answer = $tr.attr('data-answer');
		
		$(':input[name="answer"]','#submitDetail-modal-form').val(answer);
/*		$(':input[name="submitUserId"]','#submitDetail-modal-form').val(submitUserId);*/
		$(':input[name="submitUserName"]','#submitDetail-modal-form').val(submitUserName);
	});
});