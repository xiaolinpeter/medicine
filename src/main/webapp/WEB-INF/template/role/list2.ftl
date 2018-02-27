<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
<script src="${base}/resources/bootstrap-3.3.0/js/dividePage.js"></script>
<script src="${base}/resources/bootstrap-3.3.0/js/editRole.js"></script>
</head>

<body>

	<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">

		<div id="page-wrapper">
		
           <div class="container" style = "width: 970px">
           <#include "/common.ftl">
            <table class="table table-striped" id="dataTables-example">
                <thead>
                    <tr class="success">
                        <th></th>
                        <th>角色标识</th>
                        <th>角色名称</th>
                        <th>角色字符串</th>
                        <th>
                            操作
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <#list  roleList as role>
                        <tr role="row"  data-id ="${role.id}"
			                    data-name = "${role.name}"
			                    data-sn = "${role.sn}">
                            <td>
                                <input type="checkbox" value="${role.id}" class="roleId"/>
                            </td>
                            <td>${role.id}</td>
                            <td>${role.name}</td>
                            <td>${role.sn}</td>
                            <td>
                              <#--
                                <a href="${base}/admin/role/update/${role.id}">更新</a>
                                -->  
                                 <a data-toggle="modal" class="btn btn-success"  href="#edit-modal-form">更新</a>
                                <a href="${base}/admin/role/resources/${role.id}">设置资源</a>
                            </td>
                        </tr>
                    </#list>
                </tbody>
            </table>
            <br><br>
            角色操作：<#--
               <a class="btn btn-success" role="button" href="${base}/admin/role/add">添加角色</a> 
            -->
            <a id="deleteRoleBtn" class="btn btn-danger" role="button">删除角色</a>
	        <a data-toggle="modal" class="btn btn-primary"  href="#add-modal-form">添加角色</a>
        </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->
	
		<div class="modal fade" id="add-modal-form" role="dialog">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <form class="form-horizontal" action="${base}/admin/role/add" role="form" method="post" autocomplete="off">
		          <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		            <h4 class="modal-title">添加角色</h4>
		          </div>
		          <div class="modal-body">
		             <div class="form-body">
                        <div class="form-group">
                            <label for="inputName" class="col-sm-3 control-label">角色名称</label>
                            <div class="col-sm-9">
                                <input name="name" class="form-control" placeholder="请填写角色名称"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputSn" class="col-sm-3 control-label">角色表示字符串</label>
                            <div class="col-sm-9">
                                <input name="sn" class="form-control"  placeholder="请填写角色表示字符串"/>
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
		        <form class="form-horizontal" id="editForm" action="${base}/admin/role/update" role="form" method="post" autocomplete="off">
		          <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		            <h4 class="modal-title">更新角色</h4>
		          </div>
		          <div class="modal-body">
		             <div class="form-body">
		             
		               <div class="form-group">
                            <div class="col-sm-9">
                                <input  type= "hidden" name="id" class="form-control" />
                            </div>
                        </div>
		             
                        <div class="form-group">
                            <label for="inputName" class="col-sm-3 control-label">角色名称</label>
                            <div class="col-sm-9">
                                <input name="name" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputSn" class="col-sm-3 control-label">角色表示字符串</label>
                            <div class="col-sm-9">
                                <input name="sn" class="form-control"  />
                            </div>
                        </div>
		            </div>
		          </div>
		          <div class="modal-footer">
		            <button type="submit" class="btn red">保存</button>
		            <button type="button" class="btn  reset default" >重置</button>
		          </div>
		        </form>
		      </div>
		    </div>
		   </div>
		   
		   
	  <#-- 不要使用自结束 -->
        <script type="text/javascript">
            $(function(){
                $("#deleteRoleBtn").on("click",function(){
                    var checkedArray = [];
                    $("input[class='roleId']:checked").each(function () {
                        checkedArray.push($(this).val());
                    });
                    if(checkedArray.length == 0){
                        alert("请至少选择一个角色");
                    }
                    $.post("${base}/admin/role/delete",{
                        "roleIds":checkedArray
                    },function (data) {
                        if(data.success){
                            alert("删除用户成功!");
                            location.href="${base}/admin/role/list";

                        }
                    });
                });
                
                
                 $(".reset").on("click",function(){
                    document.getElementById("editForm").reset();
                });
            });

        </script>

</body>

</html>