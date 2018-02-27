<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
	<script src="${base}/resources/bootstrap-3.3.0/js/leaderPower.js"></script>
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
							<button  type="button" class="btn btn-success">组员列表</button>
						</div>
	            <table class="table table-striped" text-align="center">
	                <thead>
	                    <tr>
	                        <th>id</th>
	                        <th>组名</th>
	                        <th>用户名</th>
	                        <th>昵称</th>
	                        <th>身份</th>
	                        <th>是否申请抢答权</th>
	                        <th>状态</th>
	                        <th>操作</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <#list studentList as student>
	                      <#if (student.id == loginUser.id)>
	                        <tr style = "background-color:#6fc46f">
	                            <td><input type ="checkbox" name = "studentIds" value="${student.id}"></td>
	                            <td>${student.groupName}</td>
	                            <td>${student.studentId}</td>
	                            <td>${student.studentName}</td>
	                            <td>
	                                <#if (student.leaderFlag?? && student.leaderFlag ==1)>
	                                   <span class="label label-sm label-success">组长</span>
		                            <#else>
		                                 <span class="label label-sm label-warning">组员</span>
	                                </#if>
	                            </td>
	                            <td>
	                              <#if (student.leaderFlag ==0)>
		                                <#if (student.isFlag?? && student.isFlag ==1)>
		                                   <span class="label label-sm label-primary">已申请</span>
			                            <#elseif (student.isFlag?? && student.isFlag == 0)>
			                                 <span class="label label-sm label-danger">未申请</span>
		                                </#if>
	                                <#else>
	                               </#if>
	                            </td>
	                            <td> 
	                         
	                                <#if (student.studentFlag?? && student.studentFlag ==1)>
	                                   <span class="label label-sm label-success">已授权</span>
		                            <#elseif (student.leaderFlag?? && student.leaderFlag == 0)>
		                                 <span class="label label-sm label-warning">未授权</span>
	                                </#if>
	                        
	                            </td>
	                             <td>
	                              <#if (student.leaderFlag == 1)> <#-- 判断是否为组长-->
				                  <#elseif (student.leaderFlag == 0)>
				                           <#if (student.isFlag == 0)>
			                                <a data-student-id="${student.studentId}" data-apply-status-value="1" class="btn btn-xs success"  href="javascript:;">
					                          <i class="fa fa-check"></i> 申请授权
					                        </a>
		                               <#elseif (student.isFlag == 1)>
		                                    <a data-student-id="${student.studentId}"  data-apply-status-value="0" class="btn btn-xs red"  href="javascript:;">
					                          <i class="fa fa-close"></i> 取消申请
					                        </a>
				                       </#if>
				                  </#if>
	                             </td>
	                             
	                        </tr>
	                        <#else>
	                        <tr>
	                            <td><input type ="checkbox" name = "studentIds" value="${student.id}"></td>
	                            <td>${groupName}</td>
	                            <td>${student.studentId}</td>
	                            <td>${student.studentName}</td>
	                            <td> 
	                                <#if (student.leaderFlag?? && student.leaderFlag ==1)>
	                                   <span class="label label-sm label-success">组长</span>
		                            <#else>
		                               <span class="label label-sm label-warning">组员</span>
	                                </#if>
	                            </td>
	                             <td>
	                                 <#if (student.leaderFlag ==0)>
		                                <#if (student.isFlag?? && student.isFlag ==1)>
		                                   <span class="label label-sm label-primary">已申请</span>
			                            <#elseif (student.isFlag?? && student.isFlag == 0)>
			                                 <span class="label label-sm label-danger">未申请</span>
		                                </#if>
	                                <#else>
	                               </#if>
	                            </td>
	                            <td> 
	                             <#if (student.leaderFlag?? && student.leaderFlag ==1)>
		                             <#else>
		                                <#if (student.studentFlag?? && student.studentFlag ==1)>
		                                   <span class="label label-sm label-success">已授权</span>
			                            <#else>
			                                 <span class="label label-sm label-warning">未授权</span>
		                                </#if>
	                              </#if>
	                            </td>
	                            
	                            <td>
	                              <#if (student.leaderFlag == 1)> <#-- 判断是否为组长-->
				                  <#elseif (student.leaderFlag == 0)>
				                        <#if (student.studentFlag == 0)>
			                                <a data-student-id="${student.studentId}" data-update-status-value="1" class="btn btn-xs success" href="javascript:;">
					                          <i class="fa fa-check"></i> 授权
					                        </a>
		                               <#elseif (student.studentFlag == 1)>
		                                    <a data-student-id="${student.studentId}"  data-update-status-value="0" class="btn btn-xs red" href="javascript:;">
					                          <i class="fa fa-close"></i> 取消授权
					                        </a>
				                       </#if>
				                  </#if>
				                  
	                            </td>
	                        </tr>
	                        </#if>
	                    </#list>
	                </tbody>
	            </table>
	        </div>
	        </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->
	
   
		
</body>

</html>