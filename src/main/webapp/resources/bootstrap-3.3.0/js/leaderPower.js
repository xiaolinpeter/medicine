$(function(){

	var dom = this.element;
    //授权
	  $('.btn[data-update-status-value]', dom).click(function() {
    	var url = '/shiroTest/student/leaderPower';
    	var studentId = $(this).attr('data-student-id');
    	var status = $(this).attr('data-update-status-value');
    	$.ajax({
    		type:"POST",
    	    url:url,
    	    contentType:"application/x-www-form-urlencoded",
    	    dataType:'json',
    	    data: {
    	    	  "studentId": studentId,
    	    	  "status": status
    	    },
    	    success:function(result){
    	    	if(result.code=="0"){
					ShowSuccess("设置成功");
					setTimeout(function() {
						window.location.reload();
					}, 500);
				}else{
					ShowFailure("授权失败，你没有该权限");
				}
    	    },
    	    error:function(message){
    	    	console.info(message);
    	    }
    	});
    });
	  
	  
	  $('.btn[data-apply-status-value]', dom).click(function() {
	    	var url = '/shiroTest/student/applyPower';
	    	var studentId = $(this).attr('data-student-id');
	    	var status = $(this).attr('data-apply-status-value');
	    	$.ajax({
	    		type:"POST",
	    	    url:url,
	    	    contentType:"application/x-www-form-urlencoded",
	    	    dataType:'json',
	    	    data: {
	    	    	  "studentId": studentId,
	    	    	  "status": status
	    	    },
	    	    success:function(result){
	    	    	if(result.code=="0"){
						ShowSuccess("设置成功");
						setTimeout(function() {
							window.location.reload();
						}, 500);
					}else{
						ShowFailure("授权失败，你没有该权限");
					}
	    	    },
	    	    error:function(message){
	    	    	console.info(message);
	    	    }
	    	});
	    });
});

