$(function(){
	var dom = this.element;
    //发布或取消
	  $('.upload', dom).click(function() {
    	var url = '/shiroTest/admin/teacher/importData';
    	$.ajax({
    		type:"POST",
    	    url:url,
    	    dataType:'json',
    	    data: $('#uploadForm').serialize(),
    	    success:function(data){
    	    	if(data.code == "200"){
    	    		alert("上传成功");
    	    		window.location.reload();
    	    	}else{
    	    		alert("设置失败");
    	    	}
    	    },
    	    error:function(message){
    	    	console.info(message);
    	    }
    	});
    });
	  
});

