$(function(){
	$('.userUpdate').click(function(event){
		var username = $("#username").val();
		var nickname = $("#nickname").val();
		$.ajax({
			url : '/shiroTest/updateUser.html',
			type : 'post',
			data : {
				'username' : username,
				'nickname' : nickname,
			},
			success : function(result) {
				console.info(result);
				result = $.parseJSON(result);
				if(result.code=="0"){
						ShowSuccess("修改成功");
					setTimeout(function() {
						window.location.reload();
					}, 500);
				}else{
					$("#btnSubmit").text(result.data);
					ShowFailure(result.data);
				}
			}
		});
		
	});
	
	
	$('.passwordUpdate').click(function(event){
		var username = $("#username").val();
		var password = $("#password").val();
		var newPassword = $("#newPassword").val();
		if(newPassword != password){
			ShowSuccess("新旧密码不一致");
			window.location.reload();
		}
		$.ajax({
			url : '/shiroTest/updatePassword.html',
			type : 'post',
			data : {
				'username' : username,
				 'password' : password
			},
			success : function(result) {
				console.info(result);
				result = $.parseJSON(result);
				if(result.code=="0"){
						ShowSuccess("修改成功,重新登录");
					setTimeout(function() {
						window.location.href = "/shiroTest/logout";
					}, 1000);
				}else{
					ShowFailure(result.data);
				}
			}
		});
		
	});
	
	/*$('.userUpdate').click(function(event){
		var url = "updateUser.html";
		$.ajax({
			type : "POST",
			url : url,
			dataType : "json",
			cententType : "application/json;charset = utf-8",
			async : false,
			data : $('#userUpdateForm').serialize(),
			success:function(data){
				if(data.code == 0){
					 ShowSuccess("更新信息成功");
				}else{
					 ShowFailure("更新信息失败");
				}
				
			}
		});
		
	});*/
});