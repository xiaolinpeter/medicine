<#assign base = request.contextPath>
<html>
    <head>
        <title>用户登录</title>
        <link href="resources/bootstrap-3.3.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="${base}/resources/sbadmin/jquery/dist/jquery.min.js"></script>
       <script src="${base}/resources/bootstrap-3.3.0/js/register.js"></script>
       <script src="${base}/resources/showTip.js"></script>
        <script src="${base }/resources/sbadmin/bootstrap/dist/js/bootstrap.min.js"></script>
        <style type="text/css">
            .loginTitle{
                text-align: center;
                font-family: 微软雅黑;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <div class="loginTitle">
                <h1>教学辅助平台管理系统</h1>
            </div>
        </div>
           <div class="form-group">
              <div class="col-sm-offset-2 col-sm-8">
		     	<ul id="myTab" class="nav nav-tabs">
				   <li class="active"><a href="#home" data-toggle="tab">
				      登录</a></li>
				   <li><a href="#ios" data-toggle="tab">注册</a></li>
				 </ul>
		      </div>
		    </div>
		<div id="myTabContent" class="tab-content">
		   <div class="tab-pane fade in active" id="home">
		    <div class="form-group">
		       <div class="col-sm-8 form-group">
		       <br>
		       <br>
		       <form class="form-horizontal" role="form" method="post" action="login.html">
                <div class="form-group">
                    <label class="col-sm-offset-3 col-sm-2 control-label">用户名</label>
                    <div class="col-sm-7">
                        <input type="text" class="form-control"  id="username" placeholder="请输入用户名" onkeyup="this.value=this.value.replace(/[^\w_]/g,'')" >
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-offset-3 col-sm-2 control-label">密码</label>
                    <div class="col-sm-7">
                        <input type="password" class="form-control"  id="password"  placeholder="请输入密码" >
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-4 col-sm-10">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> Remember me
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-5 col-sm-7">
                         <button type="button" id="submitBtn" class="btn btn-primary btn-block btn-lg setWidth">登录</button>
                    </div>
                </div>
             
            </form>
              <div class="form-group">
                 <div class="col-sm-offset-5 col-sm-6 form-group" >
                     <span class="label label-danger" style="text-align: center;">${msg!}</span>
                 </div>
              </div>
               </div>
		     </div>
		   </div>
		   <div class="tab-pane fade" id="ios">
		     <div class="form-group">
		       <div class="col-sm-8 form-group">
			       <form class="form-horizontal" role="form" method="post" action="register.html">
			         <br>
		             <br>
	                <div class="form-group">
	                    <label class="col-sm-offset-3 col-sm-2 control-label">用户名</label>
	                    <div class="col-sm-7">
	                        <input type="text" class="form-control" id="username2"  placeholder="请输入用户名" >
	                    </div>
	                </div>
	               
	                <div class="form-group">
	                    <label  class="col-sm-offset-3 col-sm-2 control-label">密码</label>
	                    <div class="col-sm-7">
	                        <input type="password" class="form-control" id="password2" placeholder="请输入密码">
	                    </div>
	                </div>
	                 <div class="form-group">
                        <label  class="col-sm-offset-3 col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control" id="password3" placeholder="请再次输入密码">
                        </div>
                    </div>
                      <div class="form-group">
	                    <label  class="col-sm-offset-3 col-sm-2 control-label">验证码</label>
	                    <div class="col-sm-5">
	                        <input type="text" class="form-control" id= "emailCode" name = "emailCode" placeholder="请输入邮箱验证码">
	                    </div>
	                     <div class="col-sm-2">
	                       <button type="button"  class="btn verifyCode btn-success">获取验证码</button>
	                    </div>
	                </div>		
	                <div class="form-group">
		                <label class = "col-sm-offset-2 col-sm-3 control-label">用户类型</label>
		                   <div class="col-sm-7">
			                <select class="form-control m-b"  name="userType" id="select">
											<option value="1">管理员</option>
											<option value="2">教师</option>
											<option value="3">学生</option>
											</select>
					      </div>
	                </div>
	                <div class="form-group">
	                    <div class="col-sm-offset-5 col-sm-7">
	                         <button type="button" id="registerBtn" class="btn btn-primary btn-block btn-lg setWidth">注册</button>
	                    </div>
	                </div>
	            </form>
		      </div>
		    </div>
		  </div>
		 </div>
		 
		 <!-- 对话框HTML -->
        <div class="modal fade" id="myModal">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title" id = "modal-title"></h4>
              </div>
              <div class="modal-body">
                <p id="modal-message"></p>
              </div>
            </div>
          </div>
        </div>
         <script>
          $(document).ready(function() {
		 	
		 	var notRegistered;
			$("#username2").blur(function(){
				if($(this).val().trim().length>0){
				 checkUsername($(this).val().trim());
					if(!notRegistered){
						ShowFailure("该用户名无效");
						$("#username2").parent().addClass("has-error");
						$("#username2").focus();
					
						setTimeout(function() {
							$("#username2").parent().removeClass("has-error");
						}, 1500);
						return;
					}
				}
			});
			
			
			$("#emailCode").blur(function(){
				if($(this).val().trim().length>0){
				 checkEmailCode($(this).val().trim());
					if(!notRegistered){
						ShowFailure("验证码错误");
						$("#emailCode").parent().addClass("has-error");
						$("#emailCode").focus();
						setTimeout(function() {
							$("#emailCode").parent().removeClass("has-error");
						}, 1500);
						return;
					}
				}
			});
			
			$(".verifyCode").click(function(){
				$.ajax({
					url : '${base}/sendCheckEmail.html',
					type : 'get',
					async : false,
					dataType: 'json',
					data : {
						'username' : $("#username2").val(),
					},
					success : function(data) {
						if(data.code == "0"){
							ShowSuccess("系统已经向您的邮箱发送了验证码。（仅限一次使用）");
						}else{
						   ShowFailure("服务器错误");
						}
					},error : function(result){
					    console.info(result);
					}
		  	    });
			});
		  
		  function checkUsername(username) {
			$.ajax({
				url : '${base}/register/checkUsername',
				type : 'get',
				async : false,
				dataType: 'json',
				data : {
					'username' : username
				},
				success : function(result) {
					console.info(result);
					notRegistered=result.data;
				},error : function(result){
				    console.info(result);
				}
			});
		}
		
		 function  checkEmailCode(emailCode) {
			$.ajax({
				url : '${base}/checkEmailCode',
				type : 'get',
				async : false,
				dataType: 'json',
				data : {
					'emailCode' : emailCode
				},
				success : function(result) {
					console.info(result);
					notRegistered=result.data;
				},error : function(result){
				    console.info(result);
				}
			});
		}
		
 	  });
		
	 </script>	 
    </body>
</html>
