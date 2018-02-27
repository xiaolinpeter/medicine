$(function(){

	var dom = this.element;
    //发布
	  $('.save', dom).click(function() {
    	var url = '/shiroTest/admin/student/groupSubmit';
    	var studentId = $(this).attr('data-id');
    	$.ajax({
    		type:"POST",
    	    url:url,
    	    contentType:"application/x-www-form-urlencoded",
    	    dataType:'json',
    	    data: {
    	    	  "studentId": studentId
    	    },
    	    success:function(data){
    	    	if(data.code == "200"){
    	    		alert("提交成功");
    	    		window.location.reload();
    	    	}else if(data.code == "500"){
    	    		alert("提交失败");
    	    	}
    	    },
    	    error:function(message){
    	    	console.info(message);
    	    }
    	});
    });
	  
});

