$(function(){
	//已抢到答案小组查看答案详情
	$('#detail-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var answer = $tr.attr('data-answer');
		var title = $tr.attr('data-title');
		$(':input[name="answer"]','#detail-modal-form').val(answer);
		$(':input[name="title"]','#detail-modal-form').val(title);
	});
	
	
	//未抢到答案小组查看答案详情
	$('#allocate-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var answer = $tr.attr('data-allocateAnswer');
		$(':input[name="allocateAnswer"]','#allocate-modal-form').val(answer);
		var allocateTitle = $tr.attr('data-allocateTitle');
		$(':input[name="allocateTitle"]','#allocate-modal-form').val(allocateTitle);
	});
	
	//已抢到小组立刻评分
	$('#timeScore-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var title = $tr.attr('data-title');
		$(':input[name="title"]','#timeScore-modal-form').val(title);
		var groupId = $tr.attr('data-groupId');
		$(':input[name="groupId"]','#timeScore-modal-form').val(groupId);
	});
	
	
	//未抢到小组立刻评分
	$('#timeAllocateScore-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var allocateTitle = $tr.attr('data-allocateTitle');
		$(':input[name="allocateTitle"]','#timeAllocateScore-modal-form').val(allocateTitle);
		var groupId = $tr.attr('data-group-id');
		$(':input[name="groupId"]','#timeAllocateScore-modal-form').val(groupId);
	});
	
	
	
	
	//已抢到小组查看评分详情
	$('#score-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var title = $tr.attr('data-title');
		$(':input[name="title"]','#score-modal-form').val(title);
		var groupId = $tr.attr('data-groupId');
		$(':input[name="groupId"]','#score-modal-form').val(groupId);
		var score =$tr.attr("data-score");
		$(':input[name="score"]','#score-modal-form').val(score);
	});
	
	
	//未抢到小组查看评分详情
	$('#allocateScore-modal-form').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var allocateTitle = $tr.attr('data-allocateTitle');
		$(':input[name="allocateTitle"]','#allocateScore-modal-form').val(allocateTitle);
		var groupId = $tr.attr('data-group-id');
		$(':input[name="groupId"]','#allocateScore-modal-form').val(groupId);
		var reallyScore =$tr.attr("data-reallyScore");
		$(':input[name="score"]','#allocateScore-modal-form').val(reallyScore);
	});
	
	
});