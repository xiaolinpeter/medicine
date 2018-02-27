$(function(){
    //菜单点击 
/*    $('.delete').click(function(event){
        $(this).closest('tr').remove();
        return false;
    });*/
    
    //批量删除
    $('.deleteBatch').click(function(event){
    	var taskIdList = [];
    	var taskList = $('input[type="checkbox"]:checked');
    	taskList.each(function(){
    		taskIdList.push($(this).prop('value'));
    	});
    	alert(taskIdList);
    	var url = '/shiroTest/teacher/task/deleteBatch?arr='+taskIdList;
    	$.ajax({
    		type:"POST",
    	    url:url,
    	    contentType:"application/json; charset=utf-8",
    	    data:{taskIdList : taskIdList},
    	    dataType:'json',
    	    success:function(result){
    	    	if(result.code=="0"){
					ShowSuccess("删除成功");
					setTimeout(function() {
						window.location.reload();
					}, 500);
				}else{
					$("#btnSubmit").text(result.data);
					ShowFailure(result.data);
				}
    	    },
    	    error:function(message){
    	    	console.info(message);
    	    }
    	});
    });
});

