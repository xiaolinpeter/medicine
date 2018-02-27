<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
	<script src="${base}/resources/bootstrap-3.3.0/js/allocateLeader.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/updateGroupName.js"></script>
</head>

<body>

	<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">
         <br/><br/>
		<div id="page-wrapper">
		
            <div class="container col-md-12">
                   <div class="panel panel-default">
	                <div class="panel-heading">
								<h3><span class="label label-middle label-success">分组列表</span></h3>
					</div>
	            <table class="table table-striped">
	                <thead>
	                    <tr>
	                        <th>id</th>
	                        <th>name</th>
	                        <th>leader - leaderName</th>
	                        <th>操作</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <#list groupList as group>
	                        <tr role="row" 
								data-id="${group.id}" data-name="${group.name}"
								data-leader="${group.leader!}" >
	                            <td><input type="checkbox"  name="ids"  value="${group.id}"></td>
	                            <td>${group.name!}</td>
	                            <td >
		                            <div class="input-group" style="width:230px;">
	                                      <select name="studentId"  class="form-control select2" data-field="studentId"  data-placeholder="选择组号">
	                                        <option value="">组长</option>
	                                            <#list group.studentList as student>
	                                              <option value="${student.studentId!}"   <#if (student.leaderFlag == 1)>selected</#if>>${student.studentId} - ${student.studentName}</option>
	                                            </#list>

	                                      </select>
	                                      <a href="javascript:;" data-id="${group.id!}"  class="input-group-addon"><i class="fa fa-check"></i></a>
	                                    </div>
	                             </td>
	                            <td>
	                                 <a data-toggle="modal" href="#edit-modal-form">更新组名称</a>
	                                 <a href="${base}/teacher/group/delete?id=${group.id}"
									onclick='return confirm("确认要删除吗?")'>删除</a>
	                            </td>
	                        </tr>
	                    </#list>
	                </tbody>
	            </table>
	            <a data-toggle="modal" class="btn btn-primary"  href="#add-modal-form">添加分组</a>
	            <br/><br/>
	            </div>
	        </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->
	
	<div class="modal fade" id="add-modal-form" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <form class="form-horizontal" action="${base}/teacher/group/add" role="form" method="post" autocomplete="off">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h4 class="modal-name">添加分组</h4>
          </div>
          <div class="modal-body">
             <div class="form-body">
	             <div class="form-group">
					<label class="col-sm-2 control-label">组名：</label>
					<div class="col-sm-10">
						<input type="text" name="name" placeholder="请输入组名"
							class="form-control">
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
        <form class="form-horizontal" action="${base}/teacher/group/update" role="form" method="post" autocomplete="off">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h4 class="modal-name">修改分组</h4>
          </div>
          <div class="modal-body">
             <div class="form-body">
              <div class="form-group hidden">
					<label class="col-sm-2 control-label">组名</label>
					<div class="col-sm-10">
						<input type="text" name="groupId" placeholder="请输入组名"
							class="form-control">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-2 control-label">组名</label>
					<div class="col-sm-10">
						<input type="text" name="groupName" placeholder="请输入组名"
							class="form-control">
					</div>
				</div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn red"> 确定 </button>
            <button type="button" class="btn default" data-dismiss="modal" > 取消 </button>
          </div>
        </form>
      </div>
    </div>
   </div>
   
		
</body>

</html>