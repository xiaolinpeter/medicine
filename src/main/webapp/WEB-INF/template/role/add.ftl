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
		
		 <div class="container" style = "width : 970px">
            <#include "/common.ftl">
            <div class="panel panel-success">
                <div class="panel-heading">添加角色</div>
                <div class="panel-body">
                    <form modelAttribute="role" method="post" id="roleForm" class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="inputName" class="col-sm-2 control-label">角色名称</label>
                            <div class="col-sm-10">
                                <input name="name" class="form-control" id="inputName" placeholder="请填写角色名称"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputSn" class="col-sm-2 control-label">角色表示字符串</label>
                            <div class="col-sm-10">
                                <input name="sn" class="form-control" id="inputSn" placeholder="请填写角色表示字符串"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="submit" class="btn btn-default">添加</button>
                                <button type="reset" class="btn btn-default">重置</button>
                            </div>
                        </div>
                    </:form>
                </div>
            </div>
        </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

</body>

</html>