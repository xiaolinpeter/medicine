<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
	<script src="${base}/resources/bootstrap-3.3.0/js/editTask.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/answer.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/deleteBatch.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/submitDetail.js"></script>
	
</head>

<body>

	<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">

		<div id="page-wrapper">
		</br></br>
          <div class="container col-md-12">
                   <div class="panel panel-default">
	                <div class="panel-heading">
								<h3><span class="label label-middle label-success">小组题目</span></h3>
					</div>
	            <table class="table table-striped">
	                <thead>
	                    <tr>
	                        <th>id</th>
	                        <th>title</th>
	                        <th>description</th>
	                        <th>状态</th>
	                        <th>操作</th>
	                    </tr>
	                </thead>
	                <tbody>
	                        <tr role="row" 
								data-id="${task.id!}" data-title="${task.title!}"
								data-answer ="${task.answer!}" data-submitUserId = "${task.submitUserId!}"  data-submitUserName ="${task.submitUserName!}" data-description="${task.description!}" >
	                            <td><input type="checkbox"  name="ids"  value="${task.id!}"></td>
	                            <td>${task.title!}</td>
	                            <td>${task.description!}</td>
	                             <td><#if (task.flag ==1 )>
	                               <span class="label label-success">已作答<span> 
	                            <#else>
	                             <span class="label label-warning">未作答<span> 
	                            </#if>
	                           </td>
	                            <td><#if (task.flag ==1 )>
	                               <a data-toggle="modal" class="btn btn-primary"  href="#submitDetail-modal-form"><i class="fa fa-search"></i>查看详情 </a>
	                            <#else>
	                              <a href="${base}/student/groupAnswer?problemId=${task.id!}">作答</a>
	                            </#if>
	                           </td>
	                        </tr>
	                
	                </tbody>
	               
	            </table>
	        </div>
		</div>
		<!-- /#page-wrapper -->
	</div>
	</div>
	<!-- /#wrapper -->
	
   <div class="modal fade" id="submitDetail-modal-form" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <form class="form-horizontal" action="" role="form" method="post" autocomplete="off">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h4 class="modal-name">答案详情</h4>
          </div>
          <div class="modal-body">
             <div class="form-body">
             <div class="form-group">
					<label class="col-sm-2 control-label">提交者</label>
					<div class="col-sm-10">
						<input type="text" name="submitUserName" 
							class="form-control">
					</div>
				</div>
				
				
				<div class="form-group">
					<label class="col-sm-2 control-label">答案</label>
					<div class="col-sm-10">
                                  <textarea name="answer" class="form-control" rows="8"></textarea>
					</div>
				</div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn default" data-dismiss="modal" >关闭 </button>
          </div>
        </form>
      </div>
    </div>
   </div>
		
</body>

</html>