<#assign base = request.contextPath>
<html>

<head>
<#include "/head.ftl">
        <title>更改权限页面</title>
    </head>
<body>

	<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">

		<div id="page-wrapper">
		
            <div class="container" style = "width:970px">
            <#include "/common.ftl">
            <div class="panel panel-danger">
                <div class="panel-heading">更改权限</div>
                <div class="panel-body">
                    <form method="post" modelAttribute="resource" id="resourceForm" class="form-horizontal" role="form">
                       <div class="form-group">
                            <label for="inputName" class="col-sm-2 control-label">父权限ID：</label>
                            <div class="col-sm-10">
                                <input name="parentId"  id="name" value="${resource.parentId}" class="form-control" id="inputName" placeholder="请输入权限名称"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputName" class="col-sm-2 control-label">权限名称：</label>
                            <div class="col-sm-10">
                                <input name="name"  id="name" value="${resource.name}" class="form-control" id="inputName" placeholder="请输入权限名称"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPermission" class="col-sm-2 control-label">权限 permission ：</label>
                            <div class="col-sm-10">
                                <input name="permission" id="permission" value="${resource.permission}" class="form-control" id="inputPermission" placeholder="请输入权限 permission 字符串"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputUrl" class="col-sm-2 control-label">权限 url ：</label>
                            <div class="col-sm-10">
                                <input name="url" value="${resource.url}" id="url" class="form-control" id="inputUrl" placeholder="请输入权限 url"/>
                            </div>
                        </div>
                         <div class="form-group">
                            <label for="inputUrl" class="col-sm-2 control-label">排列顺序：</label>
                            <div class="col-sm-10">
                                <input name="rank" value="${resource.rank}" id="url" class="form-control" id="inputUrl" placeholder="请输入权限 url"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="submit" class="btn btn-default">修改</button>
                                <button type="reset"  class="btn btn-default">重置</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
	
</body>

</html>