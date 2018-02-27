$(function(){

	var dom = this.element;
    //发布或取消
	  $('.btn[data-update-status-value]', dom).click(function() {
    	var url = '/shiroTest/admin/teacher/submitCheck';
    	var id = $(this).attr('data-entity-id');
    	var status = $(this).attr('data-update-status-value');
    	$.ajax({
    		type:"POST",
    	    url:url,
    	    contentType:"application/x-www-form-urlencoded",
    	    dataType:'json',
    	    data: {
    	    	  "id": id,
   	    	   "status":status
    	    },
    	    success:function(data){
    	    	if(data.code == "200"){
    	    		alert("提交成功");
    	    		window.location.reload();
    	    	}else{
    	    		alert("提交失败");
    	    	}
    	    },
    	    error:function(message){
    	    	console.info(message);
    	    }
    	});
    });
	  
});

