$(function(){
        		$("#registerBtn").click(function(){
        		 $("#registerBtn").attr("disabled", "disabled");
        			var username= $("#username2").val().trim();
        			var password = $("#password2").val().trim();
        			var password2 = $("#password3").val().trim();
        			var userType = $("#select").val().trim();
        			if(username == "" || username == null){
        				$('#myModal').modal();
		                $("#modal-title").css({"color":"yellow"});
		                $("#modal-title").text("警告");
		                $("#modal-message").text("用户名不能为空");
		                $("#registerBtn").removeAttr("disabled");
        			}else if(password == "" || password == null || password2 == "" || password2== null){
        				$('#myModal').modal();
		                $("#modal-title").css({"color":"yellow"});
		                $("#modal-title").text("警告");
		                $("#modal-messagge").text("密码不能为空");
		                $("#registerBtn").removeAttr("disabled");
        			}else if(password2 != password){
        				$('#myModal').modal();
		                $("#modal-title").css({"color":"yellow"});
		                $("#modal-title").text("警告");
		                $("#modal-message").text("两次密码输入不一致");
		                $("#registerBtn").removeAttr("disabled");
        			}else{
        				$.ajax({
		                    url: "/shiroTest/register.html",
		                    type: "post",
		                    data: {
		                        "username":username,
		                        "password":password,
		                        "userType":userType
		                    },
		                    async: "false",
		                    dataType: "json",
		                    success: function (data) {
		                    	if(data.code == 200){
		                    		window.location.href="./login";
		                    	}else if(data.code == 201){
		                    		$('#myModal').modal();
		                    		$("#modal-title").css({"color":"yellow"});
		                    		$("#modal-title").text("警告");
		                    		$("#modal-message").text(data.message);
		                    	}else if(data.code == 202){
		                    		$('#myModal').modal();
		                    		$("#modal-title").css({"color":"yellow"});
		                    		$("#modal-title").text("警告");
		                    		$("#modal-message").text(data.message);
		                    	}else if(data.code == 203){
		                    		$('#myModal').modal();
		                    		$("#modal-title").css({"color":"yellow"});
		                    		$("#modal-title").text("警告");
		                    		$("#modal-message").text(data.message);
		                        }else if(data.code == 500){
		                    		$('#myModal').modal();
		                    		$("#modal-title").css({"color":"red"});
		                    		$("#modal-title").text("警告");
		                    		$("#modal-message").text(data.message);
		                    	}
		                		$("#submitBtn").removeAttr("disabled");
		                    },
		                    error: function (XMLHttpRequest, textStatus, errorThrown) {
		                        $('#myModal').modal();
		                    	$("#modal-title").css({"color":"red"});
		                    	$("#modal-title").text("服务器错误");
		                    	$("#modal-message").text("通讯异常");
		                    	$("#submitBtn").text("登陆");
		                		$("#submitBtn").removeAttr("disabled");
		                    },
        				})
        			}
        		});
        		
        		$("#submitBtn").click(function(){
        			var username= $("#username").val().trim();
        			var password = $("#password").val().trim();
        			if(username == "" || username == null){
        				$('#myModal').modal();
		                $("#modal-title").css({"color":"yellow"});
		                $("#modal-title").text("警告");
		                $("#modal-message").text("用户名不能为空");
        			}else if(password == "" || password == null){
        				$('#myModal').modal();
		                $("#modal-title").css({"color":"yellow"});
		                $("#modal-title").text("警告");
		                $("#modal-message").text("密码不能为空");
		                $("#submitBtn").removeAttr("disabled");
        			}else{
        				$.ajax({
		                    url: "/shiroTest/login",
		                    type: "post",
		                    data: {
		                        "username":username,
		                        "password":password,
		                    },
		                    async: "false",
		                    dataType: "json",
		                    success: function (data) {
		                    	if(data.code == 200){
		                    		window.location.href="./index.html";
		                    	}else if(data.code == 301){
		                    		window.location.href=data.url;
		                    	}else if(data.code == 201){
		                    		$('#myModal').modal();
		                    		$("#modal-title").css({"color":"yellow"});
		                    		$("#modal-title").text("警告");
		                    		$("#modal-message").text(data.message);
		                    	}else if(data.code == 202){
		                    		$('#myModal').modal();
		                    		$("#modal-title").css({"color":"yellow"});
		                    		$("#modal-title").text("警告");
		                    		$("#modal-message").text(data.message);
		                    	}else if(data.code == 203){
		                    		$('#myModal').modal();
		                    		$("#modal-title").css({"color":"yellow"});
		                    		$("#modal-title").text("警告");
		                    		$("#modal-message").text(data.message);
                                }else if(data.code == 500){
		                    		$('#myModal').modal();
		                    		$("#modal-title").css({"color":"red"});
		                    		$("#modal-title").text("警告");
		                    		$("#modal-message").text(data.message);
		                    	}
		                    },
		                    error: function (XMLHttpRequest, textStatus, errorThrown) {
		                        $('#myModal').modal();
		                    	$("#modal-title").css({"color":"red"});
		                    	$("#modal-title").text("服务器错误");
		                    	$("#modal-message").text("通讯异常");
		                    	$("#submitBtn").text("登陆");
		                		$("#submitBtn").removeAttr("disabled");
		                    },
        				})
        			}
        		})
            })