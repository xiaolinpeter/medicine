<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
	<script src="${base}/resources/bootstrap-3.3.0/js/editTask.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/deleteBatch.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/allocateLeader.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/updatesubmitName.js"></script>
	
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
								<h3><span class="label label-middle label-success">各组提交列表</span></h3>
					</div>
	            <table class="table table-striped">
	                <thead>
	                    <tr>
	                        <th>组名</th>
	                        <th>用户名</th>
	                        <th>昵称</th>
	                        <th>题目</th>
	                        <th>操作</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <#list submitList as submit>
	                        <tr>
	                             <td>
	                              ${submit.groupName!}
	                            </td>
	                            <td>${submit.studentId!}</td>
	                            <td>
	                                ${submit.studentName!}
	                            </td>
	                             <td>
	                               ${submit.title!}
	                            </td>
	                            <td>
	                                 <a data-toggle="modal" href="#edit-modal-form">查看答案详情</a>
	                                 <a href="${base}/admin/teacher/submit/delete?id=${submit.id}"
									onclick='return confirm("确认要删除吗?")'>评分</a>
	                            </td>
	                        </tr>
	                    </#list>
	                </tbody>
	            </table>
	            <br/><br/>
	            </div>
	        </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->
</body>

</html>