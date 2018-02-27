$(function(){
	
	  //答案分比例设置
    $('.input-group-addon').click(function(){
    	var url = "/shiroTest/teacher/answerPercent";
	     var answerPercent= $('select[name=answerPercent]',$(this).parent()).val();
	   	 var timePercent= $('select[name=timePercent]',$(this).parent()).val();
      if(answerPercent == undefined){
    	  $.ajax({
    	  		Type : 'POST',
    	  		url : url,
    	  		dataType : 'json',
    	  		data:{
    	  			"timePercent" :  timePercent,
    	  		},
    	  		success:function(data){
    	  			if(data.code == 0){
    	  				alert("设置成功");
    	  				window.location.reload();
    	  			}else{
    	  				alert("服务器错误")
    	  			}
    	  		},
    	  		error:function(data){
    	  			console.info(data);
    	  		},
    	  	});
      }else{
	      $.ajax({
	  		Type : 'POST',
	  		url : url,
	  		dataType : 'json',
	  		data:{
	  			"answerPercent" : answerPercent,
	  		},
	  		success:function(data){
	  			if(data.code == 0){
	  				alert("设置成功");
	  				window.location.reload();
	  			}else{
	  				alert("服务器错误")
	  			}
	  		},
	  		error:function(data){
	  			console.info(data);
	  		},
	  	});
      }
    
    });
    
    
});
