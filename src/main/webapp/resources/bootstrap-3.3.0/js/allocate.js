$(function(){
	var dom = this.element;
	  //分配题目
    $('.input-group-addon',dom).click(function(){
      var groupId = $(this).attr('data-id');
      var questionId= $('select[name=questionId]',$(this).parent()).val();
      var url = "/shiroTest/teacher/allocate";
	      $.ajax({
	  		Type : 'POST',
	  		url : url,
	  		dataType : 'json',
	  		data:{
	  			"questionId" : questionId ,
	  			"groupId" : groupId
	  		},
	  		success:function(data){
	  			if(data.code == 200){
	  				alert("设置成功");
	  				window.location.href = "/shiroTest/teacher/count";
	  			}else{
	  				alert("服务器错误")
	  			}
	  		},
	  		error:function(data){
	  			console.info(data);
	  		},
	  	});
    });
    
    
});
