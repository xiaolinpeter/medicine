<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
	<script src="${base}/resources/bootstrap-3.3.0/js/editTask.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/deleteBatch.js"></script>
	
</head>

<body>

	<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">

		<div id="page-wrapper">
		
             <div class="container col-md-12">
                   <div class="panel panel-default">
	                <div class="panel-heading">
								<h3><span class="label label-middle label-success">作业列表</span></h3>
					</div>
	            <table class="table table-striped">
	                <thead>
	                    <tr>
	                        <th>id</th>
	                        <th>title</th>
	                        <th>description</th>
	                        <th>操作</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <#list taskList as task>
	                        <tr role="row" 
								data-id="${task.id}" data-title="${task.title}"
								data-description="${task.description}" >
	                            <td><input type="checkbox"  name="ids"  value="${task.id}"></td>
	                            <td>${task.title}</td>
	                            <td>${task.description}</td>
	                            <td>
	                                 <a data-toggle="modal" href="#edit-modal-form">更新题目</a>
	                                 <a href="${base}/teacher/task/delete?id=${task.id}"
									onclick='return confirm("确认要删除吗?")'>删除</a>
	                            </td>
	                        </tr>
	                    </#list>
	                </tbody>
	            </table>
	            <a data-toggle="modal" class="btn"  href="#add-modal-form">添加题目</a>
	            <button type="button"  class="btn red deleteBatch">批量删除</button>
	        </div>
		</div>
		<!-- /#page-wrapper -->
</div>
	</div>
	<!-- /#wrapper -->
	
  <div class="modal fade" id="add-modal-form" role="dialog" >
    <div class="modal-dialog">
      <div class="modal-content">
        <form class="form-horizontal" action="${base}/teacher/task/add" role="form"  method="post" autocomplete="off">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h4 class="modal-title">添加题目</h4>
          </div>
          <div class="modal-body">
             <div class="form-body">
	             <div class="form-group">
					<label class="col-sm-2 control-label">标题：</label>
					<div class="col-sm-10">
						<input type="text" name="title" placeholder="请输入标题"
							class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">描述：</label>
					<div class="col-sm-10">
						<input type="text" name="description" placeholder="请输入描述"
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
        <form class="form-horizontal" action="${base}/teacher/task/update" role="form" method="post" autocomplete="off">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h4 class="modal-title">修改题目</h4>
          </div>
          <div class="modal-body">
             <div class="form-body">
                <div class="form-group">
					
					<div class="col-sm-10">
						<input type="hidden" name="id"  placeholder="请输入标题" 
							class="form-control" readonly = "readonly">
					</div>
				</div>
				
	             <div class="form-group">
					<label class="col-sm-2 control-label">标题：</label>
					<div class="col-sm-10">
						<input type="text" name="title" placeholder="请输入标题"
							class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">描述：</label>
					<div class="col-sm-10">
						<input type="text" name="description" placeholder="请输入描述"
							class="form-control">
					</div>
				</div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn red"> 确定 </button>
            <button type="button" class="btn default" data-dismiss="modal" > 重置 </button>
          </div>
        </form>
      </div>
    </div>
   </div>
   
		
</body>

</html>