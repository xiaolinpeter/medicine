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
		
          <div class="container" style ="width:970px">
            <#include "/common.ftl">
            <div class="panel panel-success">
                <div class="panel-heading">修改角色</div>
                <div class="panel-body">
                    <form modelAttribute="role" method="post" id="roleForm" class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="inputName" class="col-sm-2 control-label">角色名称</label>
                            <div class="col-sm-10">
                                <input name="name" class="form-control" id="inputName" value="${role.name}" placeholder="请输入角色名称"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputSn" class="col-sm-2 control-label">角色标识字符串</label>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="submit" class="btn btn-default">修改</button>
                                <button type="reset" class="btn btn-default">重置</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
            </div>
        </div>
</body>

</html>