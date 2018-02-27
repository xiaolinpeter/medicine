// 添加修改的模态框
		var addEditModal = $("#addEditModal");
		// 点击添加用户按钮
		var isShowPassword;
		$("#addUser").click(function() {
			isShowPassword=true;
			$("#password").parent().parent().show();
			$("#addEditModalTitle").text("添加用户");
			$("#btnSubmit").text("确定添加");
			$("#userid").val("");
			$("#username").val("");
			$("#username").attr("disabled",false);
			$("#nickname").val("");
			
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

		})
		
		
		var notRegistered;
	/*	$("#username").blur(function(){
			if($(this).val().trim().length>0){
			checkUsername($(this).val().trim());
				if(!notRegistered){
					$("#username").parent().addClass("has-error");
					$("#username").focus();
					setTimeout(function() {
						$("#username").parent().removeClass("has-error");
					}, 1500);
					return;
				}
			}
		});*/
		
		// 编辑按钮
		$("button.btn-primary.btn-xs").click(function(){
			console.info("编辑");
			// 
			notRegistered=true;
			isShowPassword=false;
			var userid = $(this).attr("accesskey");
			console.info("userid:"+userid);
			$("#userid").val(userid);
			var tr = $(this).parent().parent();
			$(tr).each(function() {
				var td = $(this).children();
				username = $.trim(td.eq(0).text());
				$("#username").val(username);
				nickname = $.trim(td.eq(1).text());
				$("#nickname").val(nickname);
			});
			// 不允许修改用户名
			$("#username").attr("disabled",true);
			// 因为无法获取原始密码，所以密码的只能单独修改
			$("#password").val("");
			$("#password").parent().parent().hide();
			// 权限树节点数据获取
			var zNodes;
			$.ajax({
				url : ctx + '/admin/user/roleZtree?userId='+userid,
				type : 'get',
				async : false,
				success : function(result) {
					result = $.parseJSON(result);
					zNodes = result.data;
				}
			});
			console.info(zNodes);
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			$("#disabledTrue").bind("click", {disabled: true}, disabledNode);
			$("#disabledFalse").bind("click", {disabled: false}, disabledNode);
			
			$("#addEditModalTitle").text("修改用户");
			$("#btnSubmit").text("确定修改");
			// 显示模态框
			addEditModal.modal({
				show : true,
			});
			
		})
		
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
			var roleIds = []; 
			$(nodes).each(function(i,val) {
				// console.info(val.id);
				roleIds.push(val.id);
			}) 
			//console.info(menuIds);
			//console.info(menuIds.join(","));
			
			var id=$("#userid").val().trim();
			var username=$("#username").val().trim();
			var nickname=$("#nickname").val().trim();
			var password=$("#password").val().trim();
			if (nickname.length == 0) {
				$("#nickname").parent().addClass("has-error");
				$("#nickname").focus();
				setTimeout(function() {
					$("#nickname").parent().removeClass("has-error");
				}, 1500);
				return;
			}
			if (username.length == 0) {
				$("#username").parent().addClass("has-error");
				$("#username").focus();
				setTimeout(function() {
					$("#username").parent().removeClass("has-error");
				}, 1500);
				return;
			}/* else{
				if(!notRegistered){
					$("#username").parent().addClass("has-error");
					$("#username").focus();
					ShowFailure("该用户名已被注册");
					setTimeout(function() {
						$("#username").parent().removeClass("has-error");
					}, 1500);
					return;
				}
			} */
			if(isShowPassword){
				if (password.length == 0) {
					$("#password").parent().addClass("has-error");
					$("#password").focus();
					setTimeout(function() {
						$("#password").parent().removeClass("has-error");
					}, 1500);
					return;
				}
			}
			nodes = treeObj.getCheckedNodes(true);
			console.info("第一次是为了获取数据,第二次是为了判断是否选择了");
			if(nodes.length==0){
				ShowFailure("请为用户分配角色");
				return;
			}
			console.info("id:"+id);
			console.info("username:"+username);
			console.info("password:"+password);
			console.info("nickname:"+nickname);
			console.info("roleIds:"+roleIds);
			addOrUpdateUser(id,username,password,nickname,roleIds)
			
		});
		
		/*function checkUsername(username) {
			$.ajax({
				url : ctx + '/admin/user/checkUsername',
				type : 'get',
				async : false,
				data : {
					'username' : username
				},
				success : function(result) {
					result = $.parseJSON(result);
					console.info(result);
					notRegistered=result.data;
				}
			});
		}*/
		
		function addOrUpdateUser(id,username,password,nickname,roleIds) {
			$.ajax({
				url : ctx + '/admin/user/add',
				type : 'post',
				data : {
					'id':id,
					'username' : username,
					'password' : password,
					'nickname' : nickname,
					'roleIds' : roleIds.join(",")
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
		
		// 重置密码的提示模态框
		var resetPasswordModal = $("#resetPasswordModal");
		var userId;
		// 重置密码按钮
		$("button.btn-success:contains('重置密码')").click(function(){
			resetPasswordModal.modal({
				show : true,
			});
			userId = $(this).attr("accesskey");
			
		})
		btnResetPassword
		// 点击确定重置密码
		$("#btnResetPassword").click(function() {
			resetPassword(userId);
			resetPasswordModal.modal('hide');
		});
		function resetPassword(id){
			$.ajax({
				url : ctx + '/admin/user/updatepassword',
				data : {
					'userId' : id
				},
				type : 'POST',
				success: function(data) {
					result = $.parseJSON(data);
					if(result.code=="0"){
						ShowSuccess("重置密码成功");
					}else{
						ShowFailure("操作失败："+result.data);
					}
						
					
				},
				error: function(data) {
					ShowFailure("操作失败："+data);
				}
			})
		}
		
		// 删除的提示模态框
		var deleteModal = $("#deleteModal");
		var deleteId;
		
		// 删除按钮
		$("button.btn-danger").click(function(){
			deleteModal.modal({
				show : true,
			});
			deleteId = $(this).attr("accesskey");
			
		})
		// 点击确定删除按钮
		$("#btnDelete").click(function() {
			deleteUser(deleteId);
			deleteModal.modal('hide');
		});
		
		function deleteUser(id){
			$.ajax({
				url : ctx + '/admin/user/delete/'+id,
				type : 'POST',
				success: function(data) {
					result = $.parseJSON(data);
					ShowSuccess("成功删除"+result.data+"条数据");
					setTimeout(function() {
						window.location.reload();
					}, 1000);
				},
				error: function(data) {
					ShowFailure("操作失败："+data);
				}
			})
		}
		