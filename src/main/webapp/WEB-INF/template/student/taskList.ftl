<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
	<script src="${base}/resources/bootstrap-3.3.0/js/answer.js"></script>
	
</head>

<body>
	<div id="wrapper">
		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">
		<div id="page-wrapper">
		<br/><br/><br/>
            <div class="container col-md-12">
             
					<div class="panel panel-default">
						<div class="panel-heading">
							<button type="button" class="btn btn-success">教师作业列表</button>
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
							<div class="dataTable_wrapper">
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
	                    <#list taskList as task>
	                        <tr role="row" 
								data-id="${task.id}" data-title="${task.title}"
								data-description="${task.description}" >
	                            <td><input type="checkbox"  name="ids"  value="${task.id}"></td>
	                            <td>${task.title}</td>
	                            <td>${task.description}</td>
	                            <td>
	                              <#if (task.isAnswer == 0)>
	                               	   <span class="label label-sm label-warning">未被抢</span>
	                               <#elseif (task.isAnswer == 1)>
	                                   <span class ="label label-sm label-success">已被抢答</span>
	                              </#if>
	                            </td>
	                            <td>
	                               <#if (task.isAnswer == 0)>
	                               	   <a data-entity-id="${task.id}" data-user-id= "${loginUser.id}" data-update-status-value="1" class="btn btn-xs success" href="javascript:;">
				                          <i class="fa fa-check"></i> 抢答
				                        </a>
	                               <#elseif (task.isAnswer == 1)>
	                                   
	                              </#if>
	                            </td>
	                        </tr>
	                    </#list>
	                </tbody>
	            </table>
	             </div>
		    </div>
		</div>
	        </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->
	
   
		
</body>

</html>