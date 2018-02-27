<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
<script src="${base}/resources/bootstrap-3.3.0/js/dividePage.js"></script>
<script src="${base}/resources/bootstrap-3.3.0/js/editResource.js"></script>
</head>

<body>

	<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">

		<div id="page-wrapper">
		
           <div class="container" style ="width:1020px">
           <#include "/common.ftl">
            <table class="table table-striped" id="dataTables-example">
                <thead>
                    <tr class="danger">
                        <th>资源标识</th>
                        <th>资源名称</th>
                        <th>资源 url</th>
                        <th>顺序</th>
                        <th>资源操作</th>
                    </tr>
                </thead>
                <tbody>
                    <#list resourceList as resource>
                        <tr  clas s= "role"
                        data-parentId ="${resource.parentId}"
                        data-id = "${resource.id}"
                        data-name = "${resource.name}"
                        data-permission= "${resource.permission}"
                        data-url = "${resource.url}"
                        data-isMenu = "${resource.isMenu}"
                        data-rank = "${resource.rank}"
                         >
                            <td>${resource.id}</td>
                            <td>${resource.name}</td>
                            <td>${resource.url}</td>
                            <td>${resource.rank}</td>
                            <td>
                            	<!--
                            	 <a href="${base}/admin/resource/${resource.id}">更新</a>
                            	 -->
                               
                                <a data-toggle="modal" class="btn btn-success"  href="#edit-modal-form">更新</a>
                            </td>
                        </tr>
                    </#list>
                </tbody>
            </table>
            <br><br>
            权限操作：<#--
              <a class="btn btn-danger" role="button" href="${base}/admin/resource/add">添加权限</a>
            -->
            <a data-toggle="modal" class="btn btn-primary"  href="#add-modal-form">添加权限</a>
            
        </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->
	
	<div class="modal fade" id="add-modal-form" role="dialog">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <form class="form-horizontal" action="${base}/admin/resource/add" role="form" method="post" autocomplete="off">
		          <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		            <h4 class="modal-title">添加权限</h4>
		          </div>
		          <div class="modal-body">
		             <div class="form-body">
                        <div class="form-group">
                            <label for="inputName" class="col-sm-4 control-label">父权限id：</label>
                            <div class="col-sm-7">
                                <input name="parentId" class="form-control" id="inputName" placeholder="父权限id"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputName" class="col-sm-4 control-label">权限名称：</label>
                            <div class="col-sm-7">
                                <input name="name" class="form-control" id="inputName" placeholder="请输入权限名称"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPermission" class="col-sm-4 control-label">权限 permission ：</label>
                            <div class="col-sm-7">
                                <input name="permission" class="form-control" id="inputPermission" placeholder="请输入权限 permission 字符串"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputUrl" class="col-sm-4 control-label">权限 url ：</label>
                            <div class="col-sm-7">
                                <input name="url" class="form-control" id="inputUrl" placeholder="请输入权限 url"/>
                            </div>
                        </div>
                         <div class="form-group">
                            <label class="col-sm-4 control-label">是否作为菜单</label>
			                      <div class="radio-list">
                                     <label class="radio-inline">
                                       <input type="radio" name="isMenu" value="1">
                                       <span class="label label-sm label-success inline-block">是</span>
                                     </label>
                                     <label class="radio-inline">
                                       <input type="radio" name="isMenu" value="0">
                                       <span class="label label-sm label-warning inline-block">否</span>
                                     </label>
                                 </div>
                        </div>
                          <div class="form-group">
                            <label for="inputName" class="col-sm-4 control-label">排列顺序：</label>
                            <div class="col-sm-7">
                                <input name="rank" class="form-control" id="inputName" placeholder="请输入顺序"/>
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
		        <form class="form-horizontal" action="${base}/admin/resource/update" role="form" method="post" autocomplete="off">
		          <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		            <h4 class="modal-title">更新权限</h4>
		          </div>
		          <div class="modal-body">
		             <div class="form-body">
		               <div class="form-group hidden">
                            <label for="inputName" class="col-sm-4 control-label">父权限id：</label>
                            <div class="col-sm-7">
                                <input name="id" class="form-control"  />
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="inputName" class="col-sm-4 control-label">父权限id：</label>
                            <div class="col-sm-7">
                                <input name="parentId" class="form-control" id="inputName" placeholder="父权限id"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputName" class="col-sm-4 control-label">权限名称：</label>
                            <div class="col-sm-7">
                                <input name="name" class="form-control" id="inputName" placeholder="请输入权限名称"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPermission" class="col-sm-4 control-label">权限 permission ：</label>
                            <div class="col-sm-7">
                                <input name="permission" class="form-control" id="inputPermission" placeholder="请输入权限 permission 字符串"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputUrl" class="col-sm-4 control-label">权限 url ：</label>
                            <div class="col-sm-7">
                                <input name="url" class="form-control"  placeholder="请输入权限 url"/>
                            </div>
                        </div>
                         <div class="form-group">
                            <label class="col-sm-4 control-label">是否作为菜单</label>
			                      <div class="radio-list">
                                     <label class="radio-inline">
                                       <input type="radio" name="isMenu" value="1">
                                       <span class="label label-sm label-success inline-block">是</span>
                                     </label>
                                     <label class="radio-inline">
                                       <input type="radio" name="isMenu" value="0">
                                       <span class="label label-sm label-warning inline-block">否</span>
                                     </label>
                                 </div>
                        </div>
                          <div class="form-group">
                            <label for="inputName" class="col-sm-4 control-label">排列顺序：</label>
                            <div class="col-sm-7">
                                <input name="rank" class="form-control" id="inputName" placeholder="请输入顺序"/>
                            </div>
                        </div>
		            </div>
		          </div>
		          <div class="modal-footer">
		            <button type="submit" class="btn red">更新</button>
		            <button type="reset" class="btn default" > 重置 </button>
		          </div>
		        </form>
		      </div>
		    </div>
		   </div>
	
</body>

</html>