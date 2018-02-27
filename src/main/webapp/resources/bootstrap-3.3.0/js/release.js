$(function(){

	var dom = this.element;
    //发布或取消
	  $('.btn[data-update-status-value]', dom).click(function() {
    	var url = '/shiroTest/teacher/task/handleTask';
    	var id = $(this).attr('data-entity-id');
    	var status = $(this).attr('data-update-status-value');
    	$.ajax({
    		type:"POST",
    	    url:url,
    	    dataType:'json',
    	    data: {
    	    	  "id": id,
   	    	   "status":status
    	    },
    	    success:function(result){
    	    	if(result.code=="0"){
					ShowSuccess("设置成功");
					setTimeout(function() {
						window.location.reload();
					}, 500);
				}else{
					$("#btnSubmit").text(result.data);
					ShowFailure(result.data);
				}
    	    },
    	    error:function(message){
    	    	console.info(message);
    	    }
    	});
    });
	  
	  //批量发布
	  $('.releaseBatch').click(function(event){
	    	var taskIdList = [];
	    	var taskList = $('input[type="checkbox"]:checked');
	    	taskList.each(function(){
	    		taskIdList.push($(this).prop('value'));
	    	});
	    	var url = '/shiroTest/teacher/task/releaseBatch';
	    	$.ajax({
	    		type:"POST",
	    	    url:url,
	    	    traditional :true, 
	    	    data:{
	    	    	"taskIdList" : taskIdList
	    	    	},
	    	    dataType:'json',
	    	    success:function(result){
	    	    	if(result.code=="0"){
						ShowSuccess("设置成功");
						setTimeout(function() {
							window.location.reload();
						}, 500);
					}else{
						$("#btnSubmit").text(result.data);
						ShowFailure(result.data);
					}
	    	    },
	    	    error:function(message){
	    	    	console.info(message);
	    	    }
	    	});
	    });
	  
	  
	  //批量发布
	  $('.CancelBatch').click(function(event){
	    	var taskIdList = [];
	    	var taskList = $('input[type="checkbox"]:checked');
	    	taskList.each(function(){
	    		taskIdList.push($(this).prop('value'));
	    	});
	    	var url = '/shiroTest/teacher/task/cancelBatch';
	    	$.ajax({
	    		type:"POST",
	    	    url:url,
	    	    traditional :true, 
	    	    data:{
	    	    	"taskIdList" : taskIdList
	    	    	},
	    	    dataType:'json',
	    	    success:function(result){
	    	    	if(result.code=="0"){
						ShowSuccess("设置成功");
						setTimeout(function() {
							window.location.reload();
						}, 500);
					}else{
						$("#btnSubmit").text(result.data);
						ShowFailure(result.data);
					}
	    	    },
	    	    error:function(message){
	    	    	console.info(message);
	    	    }
	    	});
	    });
});

