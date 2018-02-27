$(function(){
	var dom = this.element;
	//设置组长
    $('.input-group-addon',dom).click(function(){
      var studentId= $(this).attr('data-id');
      var groupId = $('select[name=groupId]',$(this).parent()).val();
      var url = "/shiroTest/admin/teacher/group/allocate";
	      $.ajax({
	  		Type : 'POST',
	  		url : url,
	  		dataType : 'json',
	  		data:{
	  			"studentId" : studentId ,
	  			"groupId" : groupId
	  		},
	  		success:function(data){
	  			if(data.code == 200){
	  				alert("设置成功");
	  				window.location.href = "/shiroTest/admin/teacher/studentList";
	  			}else{
	  				alert("服务器错误")
	  			}
	  		},
	  		error:function(data){
	  			console.info(data);
	  		},
	  	});
    });
    
   /* $('.input-group-addon',dom).click(function(){
      var id = $(this).attr('data-id');
      var params={};
      params.action = 'assignAgent';
      params.id = id;
      var agentId = $('select[name=agentId]',$(this).parent()).val();
      if(agentId){
        params.agentId = agentId;
      }
      self.fetchData('spider_task.json',params,function(data){
        if(data.updated == '1'){
          self.showAlertDiag('更新成功','reload',{autoClose:true});
        }
      },true);
    });*/
    
});
