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
            <div class="panel panel-danger">
                <div class="panel-heading">添加权限</div>
                <div class="panel-body">
                    <form method="post" modelAttribute="resource" id="resourceForm" class="form-horizontal" role="form">
                     
                       <div class="form-group">
                            <label for="inputName" class="col-sm-2 control-label">父权限id：</label>
                            <div class="col-sm-10">
                                <input name="parentId" class="form-control" id="inputName" placeholder="父权限id"/>
                            </div>
                        </div>
                      
                        
                        <div class="form-group">
                            <label for="inputName" class="col-sm-2 control-label">权限名称：</label>
                            <div class="col-sm-10">
                                <input name="name" class="form-control" id="inputName" placeholder="请输入权限名称"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPermission" class="col-sm-2 control-label">权限 permission ：</label>
                            <div class="col-sm-10">
                                <input name="permission" class="form-control" id="inputPermission" placeholder="请输入权限 permission 字符串"/>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="inputUrl" class="col-sm-2 control-label">权限 url ：</label>
                            <div class="col-sm-10">
                                <input name="url" class="form-control" id="inputUrl" placeholder="请输入权限 url"/>
                            </div>
                        </div>
                         <div class="form-group">
                            <label class="col-sm-2 control-label">是否作为菜单</label>
						     <div class="radio-list">
			                     <label class="radio-inline">
			                       <input type="radio" name="isMenu" value="1">
			                       <span class="label label-sm label-success inline-block">是</span>
			                     </label>
			                     <label class="radio-inline">
			                       <input type="radio" name="isMenus" value="0">
			                       <span class="label label-sm label-warning inline-block">否</span>
			                     </label>
                           </div>
                        </div>
                          <div class="form-group">
                            <label for="inputName" class="col-sm-2 control-label">排列顺序：</label>
                            <div class="col-sm-10">
                                <input name="rank" class="form-control" id="inputName" placeholder="请输入顺序"/>
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
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

</body>

</html>