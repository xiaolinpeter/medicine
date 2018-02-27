<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">

</head>

<body>

	<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">

		<div id="page-wrapper">
		
		 <div class="container" style="width: 970px">
          <#include "/common.ftl">
            <div class="panel panel-primary">
                <div class="panel-heading">添加用户</div>
                <div class="panel-body">
                    <form action="${base}/admin/user/add"
                             method="post" modelAttribute="user" id="addForm"
                             class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="inputUsername" class="col-sm-2 control-label">
                                用户名
                            </label>
                            <div class="col-sm-10">
                                <input id="username" class="form-control" name="username" placeholder="请输入用户名"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputNickname" class="col-sm-2 control-label">
                                昵称
                            </label>
                            <div class="col-sm-10">
                                <input id="nickname" class="form-control" name="nickname" placeholder="请输入昵称"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword" class="col-sm-2 control-label">
                                密码
                            </label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" name="password" placeholder="请输入密码"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputstatus" class="col-sm-2 control-label">
                                状态
                            </label>
                            <div class="col-sm-10">
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
                            <div class="col-sm-10">
                                <#list roles as role>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="roleId" value="${role.id}"/>${role.name}
                                        </label>
                                    </div>
                                </#list>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="submit" class="btn btn-default">提交</button>
                                <button type="reset" class="btn btn-default">重置</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

</body>

</html>