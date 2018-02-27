<#assign  base= "request.contextPath">
<!DOCTYPE html>
<html>
<head>
<#include  "head.ftl">
<script type="text/javascript" src="${base}/resources/bootstrap-3.3.0/js/updatePassword.js"></script>
<title>${title }</title>
</head>
<body>
	<div id="wrapper">
		<!-- 侧边导航和banner -->
          <#include  "nav.ftl">
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">个人设置</h1>
				</div>
			</div>
			<!-- /.row -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">基本信息</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#home" data-toggle="tab">个人信息修改</a></li>
								<li><a href="#profile" data-toggle="tab">登录密码修改</a></li>
							</ul>

							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="home">
									<p></p>
									<div class="row">
										<div class="col-lg-6">
											<form role="form" id = "userUpdateForm">
												<div class="form-group">
												<input type="hidden" class="form-control" name="id" disabled="disabled"
                                                        value="${loginUser.id}">
													<label>用户名</label> 
													<input class="form-control" id="username" name="username"   value="${loginUser.username}" readonly>
												</div>
												<div class="form-group">
													<label>昵称</label>    <input class="form-control" id="nickname" name="nickname" value="${loginUser.nickname}"
														placeholder="请输入昵称">
												</div>
												<button type="button" class="btn btn-success userUpdate">修改个人信息</button>
											</form>
										</div>
									</div>
								</div>
								<div class="tab-pane fade" id="profile">
									<p></p>
									<div class="row">
										<div class="col-lg-6">
											<form role="form" id = "passwordUpdateForm">
												<div class="form-group hidden">
												<input class="form-control" id="username" name="username"   value="${loginUser.username}" readonly>
												</div>
											
												<div class="form-group">
													<label>新密码</label> <input  type="password" class="form-control" id = password  placeholder="请输入新密码">
												</div>
												<div class="form-group">
													<label>确认新密码</label> <input type="password" class="form-control" id = newPassword   placeholder="请再次输入新密码">
												</div>
												<button type="button" class="btn btn-success passwordUpdate">修改登录密码</button>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
			</div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

</body>

</html>
