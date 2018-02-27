$(function(){

	var dom = this.element;
    //发布
	  $('.btn[data-update-status-value]', dom).click(function() {
    	var url = '/shiroTest/student/answer';
    	var id = $(this).attr('data-entity-id');
    	var studentId = $(this).attr('data-user-id');
    	var status = $(this).attr('data-update-status-value');
    	$.ajax({
    		type:"POST",
    	    url:url,
    	    contentType:"application/x-www-form-urlencoded",
    	    dataType:'json',
    	    data: {
    	    	  "id": id,
    	    	  "studentId" : studentId,
   	    	       "status":status
    	    },
    	    success:function(data){
    	    	if(data.code == "200"){
    	    		alert("抢答成功");
    	    		window.location.reload();
    	    	}else if(data.code == "400"){
    	    		alert(data.message);
    	    	}else{
    	    		alert("服务器错误");
    	    	}
    	    },
    	    error:function(message){
    	    	console.info(message);
    	    }
    	});
    	/*window.location.reload();*/
    });
	  
});

