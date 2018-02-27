$(function(){
	var dom = this.element;
	  //分组
    $('.input-group-addon',dom).click(function(){
      var groupId = $(this).attr('data-id');
      var studentId= $('select[name=studentId]',$(this).parent()).val();
      var url = "/shiroTest/teacher/group/allocateLeader";
	      $.ajax({
	  		Type : 'POST',
	  		url : url,
	  		dataType : 'json',
	  		data:{
	  			"studentId" : studentId ,
	  			"groupId" : groupId
	  		},
	  		success:function(result){
	  			if(result.code=="0"){
					ShowSuccess("设置成功");
					setTimeout(function() {
						window.location.reload();
					}, 500);
				}else{
					ShowFailure(result.data);
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
