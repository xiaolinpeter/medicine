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
                <div class="panel-heading">添加题目</div>
                <div class="panel-body">
                    <form action="${base}/admin/user/add"
                             method="post" modelAttribute="user" id="addForm"
                             class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="inputUsername" class="col-sm-2 control-label">
                             标题                   
                            </label>
                            <div class="col-sm-10">
                                <input id="title" class="form-control" name="title" placeholder="请输入用户名"/>
                            </div>
                        </div>
                      <div class="form-group">
                            <label for="inputUsername" class="col-sm-2 control-label">
                             描述                  
                            </label>
                            <div class="col-sm-10">
                                <input id="descritpion" class="form-control" name="descritpion" placeholder="请输入用户名"/>
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


<div class="modal fade" id="add-modal-form" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <form class="form-horizontal" action="${base}/admin/teacher/task/add" role="form" method="post" autocomplete="off">
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
</body>

</html>