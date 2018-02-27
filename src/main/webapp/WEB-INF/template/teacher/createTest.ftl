<#assign base =request.contextPath >
<html>
<head>
<#include "/head.ftl">
</head>


<body>

	<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">

		<div id="page-wrapper">
		<br>
		<br>
		<br>
		<div class="form-group">
               <div class="col-sm-4">
                 	   <a data-toggle="modal" class="btn"  href="#add-modal-form"><img src="${base}/resources/bootstrap-3.3.0/images/upload1.jpg"  alt="单题上传" /></a>
                </div>
                <div class="col-sm-4">
               		<a href="${base}/teacher/upload"><img src="${base}/resources/bootstrap-3.3.0/images/upload2.jpg" alt="文档上传" /></a>
                </div>
                 <div class="col-sm-4">
                 	<img src="${base}/resources/bootstrap-3.3.0/images/upload3.jpg" alt="图片拍照上传" />
                </div>
		</div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

    <div class="modal fade" id="add-modal-form" role="dialog" >
    <div class="modal-dialog">
      <div class="modal-content">
        <form class="form-horizontal" action="${base}/admin/teacher/task/add" role="form"  method="post" autocomplete="off">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h4 class="modal-title">添加题目</h4>
          </div>
          <div class="modal-body">
             <div class="form-body">
	             <div class="form-group">
					<label class="col-sm-2 control-label">标题：</label>
					<div class="col-sm-10">
						<input type="text" name="title" placeholder="请输入标题"
							class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">描述：</label>
					<div class="col-sm-10">
						<input type="text" name="description" placeholder="请输入描述"
							class="form-control">
					</div>
				</div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn red"> 添加</button>
            <button type="button" class="btn default" data-dismiss="modal"> 取消 </button>
          </div>
        </form>
      </div>
    </div>
   </div>

</body>

</html>
