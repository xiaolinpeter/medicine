<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
<script src="${base}/resources/bootstrap-3.3.0/js/dividePage.js"></script>
<script src="${base}/resources/bootstrap-3.3.0/js/editUser.js"></script>
</head>

<body>

	<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">

		<div id="page-wrapper">
		
         <div class="container" style = "width:970px">
	         <#include "/common.ftl">
	            <table class="table table-striped" id="dataTables-example">
	                <thead>
	                    <tr class="info">
	                        <th></th>
	                      <#-- <th>用户标识</th> -->  
	                        <th>用户名</th>
	                        <th>用户昵称</th>
	                        <th>用户状态</th>
	                        <th>用户操作</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <#list userList as user>
	                        
	                        <tr  role="row"  data-id ="${user.id}"
			                    data-username = "${user.username}"
			                    data-nickname = "${user.nickname}"
			                    data-status="${user.status}"
			                    data-password="${user.password}"
			                    data-roleIdList="${user.roleList?html}"
		                    >
	                            <td><input type="checkbox" class="userId" value="${user.id}"></td>
	                           <#--  <td>${user.id}</td>  - ${resource.permission} - ${resource.url} --> 
	                            <td>
	                                ${user.username}
	                            </td>
	                            <td>${user.nickname}</td>
	                            <td>
	                              <a class="status" data-id="${user.id}" data-status="${user.status}">启用</a>
	                            </td>
	                            <td>
	                             <#-- 
	                               <a href="${base}/admin/user/update/${user.id}">更新</a>
	                              	     <a href="${base}/admin/user/update/${user.id}">更新</a>
	                              	       <a href="${base}/admin/user/update/${user.id}">更新</a>
	                              --> 
	                               
	                               <a data-toggle="modal" class="btn btn-success"  href="#edit-modal-form">更新</a>

	                                 <a href="${base}/admin/user/resources/${user.id}">用户权限</a>
	                                 <a data-toggle="modal" class="btn btn-primary"  href="#search-modal-form">用户权限</a>
	                                 
	                            </td>
	                        </tr>
	                    </#list>
	                </tbody>
	            </table>
	            <br><br>
	            用户操作：
	            <#--  
	            <a class="btn btn-primary" role="button" href="${base}/admin/user/add">添加用户</a>
	            -->
	            <a class="btn btn-danger" role="button" href="#" id="deleteUserBtn" >删除用户</a>
	              <a data-toggle="modal" class="btn btn-primary"  href="#add-modal-form">添加用户</a>
	        </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->
	
	  <#-- 不要使用自结束 -->
       
		<div class="modal fade" id="add-modal-form" role="dialog">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <form class="form-horizontal" action="${base}/admin/user/add" role="form" method="post" autocomplete="off">
		          <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		            <h4 class="modal-title">添加用户</h4>
		          </div>
		          <div class="modal-body">
		             <div class="form-body">
		              <div class="form-group">
			             <div class="col-sm-9">
							<input type="hidden" name="id"  placeholder="请输入id" 
								class="form-control" readonly = "readonly">
						 </div>
					 </div>
			                <div class="form-group">
                            <label  class="col-sm-2 control-label">
                                用户名
                            </label>
                            <div class="col-sm-9">
                                <input id="username" class="form-control" name="username" placeholder="请输入用户名"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">
                                昵称
                            </label>
                            <div class="col-sm-9">
                                <input id="nickname" class="form-control" name="nickname" placeholder="请输入昵称"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">
                                密码
                            </label>
                            <div class="col-sm-9">
                                <input type="password" class="form-control" name="password" placeholder="请输入密码"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputstatus" class="col-sm-2 control-label">
                                状态
                            </label>
                            <div class="col-sm-9">
                                <select name="status"  class="form-control">
                                    <option value="0">停用</option>
                                    <option value="1">启用</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">
                                角色
                            </label>
                            <div class="col-sm-9">
                                <#list roles as role>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="roleId" value="${role.id}"/>${role.name}
                                        </label>
                                    </div>
                                </#list>
                            </div>
                        </div>
		            </div>
		          </div>
		          <div class="modal-footer">
		            <button type="submit" class="btn red"> 添加</button>
		            <button type="button" class="btn default" data-dismiss="modal"> 取消 </button>
		          </div>
		        </form>
		      </div>
		    </div>
		   </div>
		   
		   
	 <div class="modal fade" id="edit-modal-form" role="dialog">
	    <div class="modal-dialog">
	      <div class="modal-content">
	        <form class="form-horizontal" action="${base}/admin/user/update" role="form" method="post" autocomplete="off">
	          <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	            <h4 class="modal-title">修改用户信息</h4>
	          </div>
	          <div class="modal-body">
	             <div class="form-body">
	                <div class="form-group">
						
						<div class="col-sm-9">
							<input type="hidden" name="id" 
								class="form-control" readonly = "readonly">
						</div>
					</div>
					
	              <div class="form-group">
	                    <label for="inputUsername" class="col-sm-2 control-label">用户名</label>
	                    <div class="col-sm-9">
	                        <input name="username" class="form-control" id="inputUsername"  />
	                    </div>
	                </div>
	
	                <div class="form-group">
	                    <label for="inputNickname" class="col-sm-2 control-label">昵称</label>
	                    <div class="col-sm-9">
	                        <input name="nickname" class="form-control" id="inputNickname"  />
	                    </div>
	                </div>
	
	                <div class="form-group">
	                    <label for="inputPassword" class="col-sm-2 control-label">密码</label>
	                    <div class="col-sm-9">
	                        <#--<input path="password" class="form-control"  placeholder="请输入密码"/>-->
	                        <input class="form-control" name="password"  readonly/>
	                    </div>
	                </div>
	
	                <div class="form-group">
	                    <label for="inputStatus" class="col-sm-2 control-label">状态</label>
	                    <div class="col-sm-9">
	                      <#--
		                      <select name="status" class="form-control">
		                            <option value="0">停用</option>
		                            <option value="1">启用</option>
		                        </select>  
	                      -->  
	                          <div class="radio-list">
			                     <label class="radio-inline">
			                       <input type="radio" name="status" value="1">
			                       <span class="label label-sm label-success inline-block">启用</span>
			                     </label>
			                     <label class="radio-inline">
			                       <input type="radio" name="status" value="0">
			                       <span class="label label-sm label-warning inline-block">停用</span>
			                     </label>
	                          </div>
	                    </div>
	                </div>
	                
	                  <div class="form-group">
                            <label class="col-sm-2 control-label">角色</label>
                            <div class="col-sm-9">
                                <#-- 先把后台传递过来的 List 数组转换为 JS 能识别的数组
                                <#list hasRole as hr>
                                    <input type="hidden" class="hasRole" value="${hr}"/>
                                </#list>
                                 -->
                                <#-- 然后再给页面上的复选框赋值 -->
                                <#list  roles as role>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="roleId" value="${role.id}"/>
                                                ${role.name}
                                        </label>
                                    </div>
                                </#list>
                            </div>
                        </div>
	            </div>
	          </div>
	          <div class="modal-footer">
	            <button type="submit" class="btn red"> 确定 </button>
	            <button type="reset" class="btn default"> 重置 </button>
	          </div>
	        </form>
	      </div>
	    </div>
	   </div>
	   
	   
	   <div class="modal fade" id="search-modal-form" role="dialog">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <form class="form-horizontal" action="${base}/admin/user/add" role="form" method="post" autocomplete="off">
		          <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		            <h4 class="modal-title">用户权限</h4>
		          </div>
		          <div class="modal-body">
		             <div class="form-body">
		             <table class="table">
						  <thead>
						    <tr>
						      <th>资源名称</th>
						      <th>资源 url</th>
						      <th>资源权限字符串</th>
						    </tr>
						  </thead>
						  <tbody>
	                      <#list userList as user>
						    <tr>
						      <td>${user.username}</td>
						      <td>${user.nickname}</td>
						      <td>${user.status}</td>
						    </tr>
	                      </#list>
						  </tbody>
						</table>
		            </div>
		          </div>
		           <#--
		              <div class="modal-footer">
			            <button type="submit" class="btn red"> 添加</button>
			            <button type="button" class="btn default" data-dismiss="modal"> 取消 </button>
		              </div>
		           -->
		         
		        </form>
		      </div>
		    </div>
		   </div>
		   
		   
		    <script type="text/javascript">
            $(function(){
                $(".status").each(function(){
                    var status = $(this).attr("data-status");
                    var oper = $(this);
                    if(status == 1){
                        oper.text("禁用");
                    }else {
                        oper.text("启用");
                    }
                });

                $(".status").on("click",function(){
                    var oper = $(this);
                    var user_id = oper.attr("data-id");
                    var user_status = oper.attr("data-status");
                    var update_status = (user_status == 1 ? 0: 1);
                    $.post("${base}/admin/user/updateStatus",
                            {
                                id:user_id,
                                status:update_status
                            },function(data){
                                if(data.success){
                                    alert("修改状态成功！");
                                    var oper_name = (update_status == 1 ? "禁用":"启用");
                                    oper.attr("data-status",update_status);
                                    oper.text(oper_name);
                                }else{
                                    alert("失败");
                                }
                            }
                    );

                });


                // 批量删除
                $("#deleteUserBtn").on("click",function(){
                    var checkedArray =[];
                    $('input[class="userId"]:checked').each(function(){
                        checkedArray.push($(this).val());
                    });

                    if(checkedArray.length==0){
                        alert("您还没有选择要删除的内容!");
                        return;
                    }
                    // 这里也可以使用表单提交的方式删除
                    $.ajax({
                        type:"post",
                        url:"${base}/admin/user/delete",
                        dataType:"json",
                        data:{
                            userIds:checkedArray,
                            testData:"testStr"
                        },
                        success:function (data) {
                            if(data.success){
                                alert("数据删除成功!");
                                location.href = "${base}/admin/user/list";
                            }else {
                                alert(data.errorInfo);
                            }
                        },
                        error:function () {
                            alert("您没有相应的权限删除用户数据,请联系管理员");
                        }

                    });
                });
            })
        </script>
</body>

</html>