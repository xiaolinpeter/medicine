$(function(){
    //菜单点击 
/*    $('.delete').click(function(event){
        $(this).closest('tr').remove();
        return false;
    });*/
    
    //批量删除
    $('.deleteBatch').click(function(event){
    	var taskIdList = [];
    	var studentList = $('input[type="checkbox"]:checked');
    	studentList.each(function(){
    		taskIdList.push($(this).prop('value'));
    	});
    	alert(taskIdList);
    	var url = '/admin/teacher/task/deleteBatch?arr='+taskIdList;
    	$.ajax({
    		type:"POST",
    	    url:url,
    	    contentType:"application/json; charset=utf-8",
    	    data:{taskIdList : taskIdList},
    	    dataType:'json',
    	    success:function(message){
    	    	window.location.reload();
    	    },
    	    error:function(message){
    	    	console.info(message);
    	    }
    	});
    	window.location.reload();
    });
});

