<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
<script src="${base}/resources/bootstrap-3.3.0/js/release.js"></script>
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
								<h3><span class="label label-middle label-success">作业发布</span></h3>
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
	                    <#list taskList as task>
	                        <tr role="row" 
								data-id="${task.id}" data-title="${task.title}"
								data-description="${task.description}" >
	                            <td><input type="checkbox"  name="ids"  value="${task.id}"></td>
	                            <td>${task.title}</td>
	                            <td>${task.description}</td>
	                            <td>
	                               <#if (task.isRelease == 0)>
	                               	   <span class="label label-sm label-warning">未发布</span>
	                               <#elseif (task.isRelease== 1)>
	                                   <span class ="label label-sm label-success">已发布</span>
	                              </#if>
	                            </td>
	                             <td>
	                               <#if (task.isRelease == 0)>
	                               	   <a data-entity-id="${task.id}" data-update-status-value="1" class="btn btn-xs success" href="javascript:;">
				                          <i class="fa fa-check"></i> 发布
				                        </a>
	                               <#elseif (task.isRelease == 1)>
	                                   <a data-entity-id="${task.id}" data-update-status-value="0" class="btn btn-xs red" href="javascript:;">
				                          <i class="fa fa-close"></i> 取消
				                        </a>
	                              </#if>
	                            </td>
	                        </tr>
	                    </#list>
	                </tbody>
	            </table>
	            	<br/><br/>
	              <button type="button"  class="btn releaseBatch btn-primary">批量发布</button>
	              <button type="button"  class="btn cancelBatch btn-success">批量取消</button>
	        </div>
	        </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->
	
	
   
		
</body>

</html>