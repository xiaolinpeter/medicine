$(function(){

	$('#addEditModal').on('show.bs.modal',function(event){
		var source = event.relatedTarget;
		var $tr = $(source).closest('tr');
		var id = $tr.attr('data-id');
		var name = $tr.attr('data-name');
		$(':input[name="userId"]','#addEditModal').val(id);
		$(':input[name="userName"]','#addEditModal').val(name);
		$("#addEditModalTitle").text("教师授权");
		$("#btnSubmit").text("确定授权");
		// $("#roleId").val("");
		// $("#roleName").val("");
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
	
	});
	
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
				url :  '/shiroTest/teacher/role/menuZtree',
				type : 'get',
				async : false,
				success : function(result) {
					result = $.parseJSON(result);
					zNodes =  result.data;
				}
			});
		}
		
		
	
		
		// 分配权限的显示和隐藏
		$("#btnAllocatePermission").click(function() {
			$("#menuDiv").toggle("fast");
		});
		
		
		// 点击确定授权按钮
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
			
			var userId=$("#userId").val().trim();
			var name=$("#userName").val().trim();
			if (name.length == 0) {
				$("#roleName").parent().addClass("has-error");
				$("#roleName").focus();
				setTimeout(function() {
					$("#userName").parent().removeClass("has-error");
				}, 1500);
				return;
			}
			nodes = treeObj.getCheckedNodes(true);
			console.info("第一次是为了获取数据,第二次是为了判断是否选择了");
			if(nodes.length==0){
				ShowFailure("请为角色分配权限");
				return;
			}
			console.info("id:"+userId);
			console.info("name:"+name);
			console.info("resourceIds:"+resourceIds);
			reallyPower(userId,name,resourceIds);
			
		});
		
		
		function reallyPower(id,name,resourceIds) {
			$.ajax({
				url : '/shiroTest/teacher/teacherPower',
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
						$("#btnSubmit").text("授权成功");
						ShowSuccess("授权成功");
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
});
	  

