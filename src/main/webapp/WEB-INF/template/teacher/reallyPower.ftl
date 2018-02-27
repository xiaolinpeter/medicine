<!--
  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/tag.jsp"%>
-->
<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
<script src="${base}/resources/bootstrap-3.3.0/js/dividePage.js"></script>
</head>
<!DOCTYPE html>
<html>
<head>
<link href="${base}/resources/plugins/ztree/css/zTreeStyle/zTreeStyle.css"
	rel="stylesheet" type="text/css">
<#--
  <title>${title }</title>
-->0.
</head>
<body>
	<div id="wrapper">
		<!-- 侧边导航和banner -->
		 <#include "/nav.ftl">
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header"><#--
                      <title>${title }</title>
                    --></h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- 添加，修改角色的模态框 -->
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
								<div class="form-group">
									<label class="col-sm-2 control-label">角色名称</label>
									<div class="col-sm-10">
										<input id="roleId" type="hidden" >
										<input type="text" class="form-control" id="roleName"
											placeholder="请输入角色名称">
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
			<!-- /.modal -->
			<!-- /.row -->
		    <!-- /.row -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<button id="addRole" type="button" class="btn btn-success">添加角色</button>
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
					
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /#page-wrapper -->
	</div>
</body>
<script type="text/javascript"
	src="${base}/resources/plugins/ztree/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="${base}/resources/plugins/ztree/js/jquery.ztree.excheck.js"></script>
<script>
	$(document).ready(function() {					
						// ztree需要的
						function disabledNode(e) {
							var zTree = $.fn.zTree.getZTreeObj("treeDemo"), disabled = e.data.disabled, nodes = zTree
									.getSelectedNodes(), inheritParent = false, inheritChildren = false;
							if (nodes.length == 0) {
								alert("请先选择一个节点");
							}
							if (disabled) {
								inheritParent = $("#py").attr("checked");
								inheritChildren = $("#sy").attr("checked");
							} else {
								inheritParent = $("#pn").attr("checked");
								inheritChildren = $("#sn").attr("checked");
							}

							for (var i = 0, l = nodes.length; i < l; i++) {
								zTree.setChkDisabled(nodes[i], disabled,
										inheritParent, inheritChildren);
							}
						}
						// ztree需要的
						var setting = {
								check: {
									enable: true,
									chkDisabledInherit: true
								},
								data: {
									simpleData: {
										enable: true
									}
								}
						};
						
						
						var zNodes;
						
						function initZtree(){
							var data;
							$.ajax({
								url :  '${base}/admin/role/menuZtree',
								type : 'get',
								async : false,
								success : function(result) {
									result = $.parseJSON(result);
									zNodes =  result.data;
								}
							});
						}
						
						// 添加修改的模态框
						var addEditModal = $("#addEditModal");

						// 点击添加角色按钮
						$("#addRole").click(function() {
							$("#addEditModalTitle").text("添加角色");
							$("#btnSubmit").text("确定添加");
							$("#roleId").val("");
							$("#roleName").val("");
							// 让zNodes有值
							initZtree();
							console.info(zNodes);
							$.fn.zTree.init($("#treeDemo"), setting, zNodes);
							$("#disabledTrue").bind("click", {disabled: true}, disabledNode);
							$("#disabledFalse").bind("click", {disabled: false}, disabledNode);
							// 重新分配
							var treeObj= $.fn.zTree.getZTreeObj("treeDemo");
							treeObj.checkAllNodes(false);
							// 显示模态框
							addEditModal.modal({
								show : true,
							});

						});
						
					
						
						// 分配权限的显示和隐藏
						$("#btnAllocatePermission").click(function() {
							$("#menuDiv").toggle("fast");
						});
						
						
						// 点击确定添加按钮
						$("#btnSubmit").click(function() {
							treeObj= $.fn.zTree.getZTreeObj("treeDemo");
							// 遍历所有节点，恢复禁用状态为活动状态
							var dsblNodes = treeObj.getNodesByParam("chkDisabled", true);

							// 遍历节点取消禁用状态
							for (var i=0, l=dsblNodes.length; i < l; i++) {

							    // 取消禁用状态
							    treeObj.setChkDisabled(dsblNodes[i], false);
							}
							// 取得选中的节点
							var nodes = treeObj.getCheckedNodes(true);

							// 遍历节点恢复禁用状态
							for (var i=0, l=dsblNodes.length; i < l; i++) {
							    // 恢复禁用状态
							    treeObj.setChkDisabled(dsblNodes[i], true);
							}
							console.info(nodes);
							var resourceIds = []; 
							$(nodes).each(function(i,val) {
								// console.info(val.id);
								resourceIds.push(val.id);
							}) 
							//console.info(resourceIds);
							//console.info(resourceIds.join(","));
							
							var id=$("#roleId").val().trim();
							var name=$("#roleName").val().trim();
							if (name.length == 0) {
								$("#roleName").parent().addClass("has-error");
								$("#roleName").focus();
								setTimeout(function() {
									$("#roleName").parent().removeClass("has-error");
								}, 1500);
								return;
							}
							nodes = treeObj.getCheckedNodes(true);
							console.info("第一次是为了获取数据,第二次是为了判断是否选择了");
							if(nodes.length==0){
								ShowFailure("请为角色分配权限");
								return;
							}
							console.info("id:"+id);
							console.info("name:"+name);
							console.info("resourceIds:"+resourceIds);
							addRole(id,name,resourceIds);
							
						});
						
						
						function addRole(id,name,resourceIds) {
							$.ajax({
								url : '${base}/admin/role/add',
								type : 'post',
								data : {
									'id':id,
									'name' : name,
									'resourceIds' : resourceIds.join(",")
								},
								success : function(result) {
									console.info(result);
									result = $.parseJSON(result);
									if(result.code=="0"){
										$("#btnSubmit").attr("disabled",true);
										if(id.length>0){
											$("#btnSubmit").text("修改成功");
											ShowSuccess("修改成功");
										}else{
											$("#btnSubmit").text("添加成功");
											ShowSuccess("添加成功");
										}
										setTimeout(function() {
											window.location.reload();
										}, 500);
										
									}else{
										$("#btnSubmit").text(result.data);
										ShowFailure(result.data);
									}
								}
							});
						}
					
				// 分页插件
					});
</script>

</html>
