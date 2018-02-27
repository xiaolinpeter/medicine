$(function(){
	var dom = this.element;
	
    //发布或取消
	  $('.teacherPower', dom).click(function() {
		var studentId = $(this).attr('data-student-id');
		var powerList = $('input[type = "checkbox"]:checked');
		var powerIdList = [];
		powerList.each(function(){
			powerIdList.push($(this).prop('value'));
		});
		alert(powerIdList);
    	var url = '/shiroTest/admin/teacher/teacherPower';
    	var studentId = $(this).attr('data-student-id');
    	$.ajax({
    		type:"POST",
    	    url:url,
    	    contentType:"application/x-www-form-urlencoded",
    	    dataType:'json',
    	    traditional:true,
    	    data: {
    	    	  "studentId": studentId,
    	    	  "powerIdList":powerIdList
    	    },
    	    success:function(data){
    	    	if(data.code == "200"){
    	    		alert("设置成功");
    	    		window.location.href = "/shiroTest/admin/teacher/studentList";
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

