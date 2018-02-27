$(function(){
	var dom = this.element;
	//解析数据
    $('.analyze',dom).click(function(){
      var url = "/shiroTest/admin/teacher/analyzeData";
      var fileId = $(this).attr('data-file-id');
      var name= $(this).attr('data-file-name');
      var teacherId = $(this).attr('data-teacher-id');
	      $.ajax({
	  		Type : 'POST',
	  		url : url,
	  		dataType : 'json',
	  		data:{
	  			"url" : url,
	  			"fileId" : fileId,
	  			"name" : name,
	  			"teacherId" : teacherId
	  		},
	  		success:function(data){
	  			if(data.code == 200){
	  				alert("解析并导入成功");
	  				window.location.reload();
	  			}else{
	  				alert("操作失败")
	  			}
	  		},
	  		error:function(data){
	  			console.info(data);
	  		},
	  	});
    });
    
    
});
