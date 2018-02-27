$(function(){
	var dom = this.element;
	//设置组长
    $('.importData',dom).click(function(){
      var url = "/shiroTest/admin/teacher/importData";
	      $.ajax({
	  		Type : 'POST',
	  		url : url,
	  		dataType : 'json',
	  		data:{
	  		},
	  		success:function(data){
	  			if(data.code == 200){
	  				alert("导入成功");
	  				window.location.reload();
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
