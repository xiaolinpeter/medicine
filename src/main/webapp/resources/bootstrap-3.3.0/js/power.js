$(function(){

	var dom = this.element;
    //发布或取消
	  $('.power', dom).click(function() {
    	var url = '/shiroTest/admin/teacher/power';
    	var studentId = $(this).attr('data-student-id');
    	
    	$.ajax({
    		type:"POST",
    	    url:url,
    	    contentType:"application/x-www-form-urlencoded",
    	    dataType:'json',
    	    data: {
    	    	  "studentId": studentId,
    	    },
    	    success:function(data){
    	    	/*if(data.code == "200"){
    	    		alert("设置成功");
    	    	}else{
    	    		alert("设置失败");
    	    	}*/
    	    },
    	    error:function(message){
    	    	console.info(message);
    	    }
    	});
    });
	  
});

