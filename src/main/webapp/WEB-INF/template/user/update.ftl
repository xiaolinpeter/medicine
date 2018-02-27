<#assign base = request.contextPath>
<html>

<head>
<#include "/head.ftl">
        <title>修改用户信息</title>
</head>
<body>

	<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">

		<div id="page-wrapper">
		
             <div class="container">
        <#include "/common.ftl">
            <span></span>
            <div class="panel panel-info">
                <div class="panel-heading">修改用户信息</div>
                <div class="panel-body">
                    <form method="post" modelAttribute="user" id="updateForm" class="form-horizontal" role="form">

                        <div class="form-group">
                            <label for="inputUsername" class="col-sm-2 control-label">用户名</label>
                            <div class="col-sm-10">
                                <input name="username" class="form-control" id="inputUsername"  value="${user.username}" placeholder="请输入用户名"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="inputNickname" class="col-sm-2 control-label">昵称</label>
                            <div class="col-sm-10">
                                <input name="nickname" class="form-control" id="inputNickname" value="${user.nickname}" placeholder="请输入昵称"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="inputPassword" class="col-sm-2 control-label">密码</label>
                            <div class="col-sm-10">
                                <#--<input path="password" class="form-control" id="inputPassword" placeholder="请输入密码"/>-->
                                <input class="form-control" name="password" id="inputPassword" value="${user.password}" readonly/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="inputStatus" class="col-sm-2 control-label">状态</label>
                            <div class="col-sm-10">
                                <select name="status" class="form-control" id="inputStatus">
                                    <option value="0">停用</option>
                                    <option value="1">启用</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">角色</label>
                            <div class="col-sm-10">
                                <#-- 先把后台传递过来的 List 数组转换为 JS 能识别的数组 -->
                                <#list hasRole as hr>
                                    <input type="hidden" class="hasRole" value="${hr}"/>
                                </#list>
                                <#-- 然后再给页面上的复选框赋值 -->
                                <#list  roles as role>
                                    <div class="checkbox">
                                        <label>
                                            <input class="roleId" type="checkbox" name="roleId" value="${role.id}"/>
                                                ${role.name}
                                        </label>
                                    </div>
                                </#list>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <input class="btn btn-default" role="button" type="submit" value="提交修改">
                                <input class="btn btn-default" role="button" type="reset" value="重置">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
            </div>
        </div>
	 <#-- script 节点不要使用自结束 -->
        <script type="text/javascript">
            $(function(){
                // 先把后台传递过来的 List 数组转换为 JS 能识别的数组
                var hasRoles = new Array();
                $(".hasRole").each(function(){
                   hasRoles.push($(this).val());
                });

                // 然后再给页面上的复选框赋值
                $(".roleId").each(function(){
                    var roleCheckbox = $(this);
                    var value = roleCheckbox.val();
                    if($.inArray(value,hasRoles)>=0){
                        roleCheckbox.attr("checked","checked");
                    }
                });
            });
        </script>
</body>

</html>