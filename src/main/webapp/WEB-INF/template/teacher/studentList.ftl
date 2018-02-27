<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
	<script src="${base}/resources/bootstrap-3.3.0/js/studentLeader.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/power2.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/select2.full.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/select2.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/importData.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/upload.js"></script>
	<link href="${base}/resources/plugins/ztree/css/zTreeStyle/zTreeStyle.css"
	rel="stylesheet" type="text/css">
    <link href="${base}/resources/bootstrap-fileinput-master/css/fileinput.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="${base}/resources/bootstrap-fileinput-master/themes/explorer-fa/theme.css" media="all" rel="stylesheet" type="text/css"/>
    <script src="${base}/resources/bootstrap-fileinput-master/js/plugins/sortable.js" type="text/javascript"></script>
    <script src="${base}/resources/bootstrap-fileinput-master/js/fileinput.js" type="text/javascript"></script>
    <script src="${base}/resources/bootstrap-fileinput-master/js/locales/fr.js" type="text/javascript"></script>
    <script src="${base}/resources/bootstrap-fileinput-master/js/locales/es.js" type="text/javascript"></script>
    <script src="${base}/resources/bootstrap-fileinput-master/themes/explorer-fa/theme.js" type="text/javascript"></script>
    <script src="${base}/resources/bootstrap-fileinput-master/themes/fa/theme.js" type="text/javascript"></script>
    <script src="${base}/resources/bootstrap-fileinput-master/js/popper.min.js" type="text/javascript"></script>
	
</head>

<body>

	<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">

  
		<div id="page-wrapper" >
		   <div class="modal fade" id="addEditModal" tabindex="-1" role="dialog"
				aria-labelledby="addEditModalTitle" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="addEditModalTitle"></h4>
						</div>
						<div class="modal-body">
							<div class="form-horizontal">
							   <div class="form-group hidden">
									<label class="col-sm-2 control-label">用户id</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="userId" name ="userId" placeholder="请输入用户名">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">用户名</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" name="userName" id="userName"
										placeholder="请输入用户名">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">分配权限</label>
									<div class="col-sm-10">
										<button class="btn btn-info" id="btnAllocatePermission">
											分配权限
										</button>
									</div>
								</div>
								<div class="form-group" id="menuDiv" style="display: none">
									<div class="col-sm-10 col-sm-offset-2">
										<ul id="treeDemo" class="ztree"></ul>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">取消</button>
							<button id="btnSubmit" type="button" class="btn btn-primary">确定</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
                <div class="container col-md-12">
                   <div class="panel panel-default">
	                <div class="panel-heading">
								<h3><span class="label label-middle label-success">学生列表</span></h3>
					</div>
					<div class="panel-body">
						<div class="dataTable_wrapper">
			            <table class="table table-striped" id = "dataTables-example">
			                <thead>
			                    <tr>
			                        <th style="text-align:center">id</th>
			                        <th style="text-align:center">用户名</th>
			                        <th style="text-align:center">昵称</th>
			                        <th style="text-align:center">授权</th>
			                    </tr>
			                </thead>
			                <tbody>
			                    <#list studentList as student>
			                        <tr role="row"  data-id = ${student.id}
			                         data-name = ${student.username}
			                        style="text-align:center">
			                            <td><input type="checkbox" name="id"  value="${student.id}"></td>
			                            <td>${student.username}</td>
			                            <td>${student.nickname}</td>
			                            <td><#--
			                                    <a  class="btn power success"  data-student-id="${student.id}" href="${base}/admin/teacher/power">
						                          <i class="fa fa-check"></i> 授权
						                        </a>
						                         <button id="power" type="button" data-id=${student.id} class="btn btn-success">授权</button>
						                           
			                             -->   
						                          <a data-toggle="modal" class="btn"  href="#addEditModal">授权</a>
						                 </td>
			                        </tr>
			                    </#list>
			                  
			                </tbody>
			            </table>
			           </div>
		         </div>
		        </div>   
		        <#if (studentList?? && (studentList?size = 0))>   
	              <div class="form-group">
			               <div class="col-sm-4">
			                 	   <a class="btn btn-primary" role="button" href="${base}/admin/teacher/upload">导入数据</a>
			               </div>
		          </div>
		        </#if>
	        </div>
		</div> 
		<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->
	<script type="text/javascript"
	src="${base}/resources/plugins/ztree/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="${base}/resources/plugins/ztree/js/jquery.ztree.excheck.js"></script>
<script>
	$(document).ready(function() {					
						// ztree需要的
				// 分页插件
				$('#dataTables-example').DataTable({
						bSort : false,
						destroy:true,
						"sPaginationType" : "full_numbers",
						"oLanguage" : {
							"sLengthMenu" : "每页显示 _MENU_ 条记录",
							"sZeroRecords" : "抱歉， 没有找到",
							"sInfo" : "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
							"sInfoEmpty" : "没有数据",
							"sInfoFiltered" : "(从 _MAX_ 条数据中检索)",
							"sZeroRecords" : "没有检索到数据",
							"sSearch" : "搜索:",
							"oPaginate" : {
								"sFirst" : "首页",
								"sPrevious" : "上一页",
								"sNext" : "下一页",
								"sLast" : "尾页"
							}
						}
					});
				});
</script>
</body>

</html>