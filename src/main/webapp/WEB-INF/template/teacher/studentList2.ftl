<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
	<script src="${base}/resources/bootstrap-3.3.0/js/studentLeader.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/select2.full.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/select2.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/dividePage.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/importData.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/upload.js"></script>
	
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

  
		<div id="page-wrapper">
              
	    
	    <form enctype="multipart/form-data" id= "uploadForm" method="post" action="${base}/admin/teacher/upload">
			        <hr>
			        <div class="form-group">
			            <div class="file-loading">
			                <input id="file-0d" class="file" type="file"  name="image">
			            </div>
			        </div>
			        <hr>
			         <button type="submit" class="btn upload btn-primary">Submit</button>
			         <button type="reset" class="btn btn-default">Reset</button>
        </form>
	
         <!--
         
         <form action="${base}/admin/teacher/upload" enctype="multipart/form-data" method="post">
			<table>
				<tr>
					<td>请上传头像:</td>
					<td><input type="file" name="image"></td>
				</tr>
				<tr>
					<td><input type="submit" value="注册"></td>
				</tr>
			</table>
	   </form>
         
        
              
         <div class="container" style = "width:970px">
	            <table class="table table-striped" id = "dataTables-example">
	                <thead>
	                    <tr class="info">
	                        <th>学号</th>
	                        <th>用户名</th>
	                        <th>职称</th>
	                        <th>分组</th>
	                        <th>授权</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <#list studentList as student>
	                        <tr>
	                            <td>${student.id}</td>
	                            <td>${student.username}</td>
	                            <td>${student.nickname}</td>
	                            <td>
                    	           <div class="input-group" style="width:180px;">
                                      <select name="groupId"  class="form-control select2" data-field="groupId"  data-placeholder="选择组号">
                                        <option value="">组号</option>
                                            <#list groupList as group>
                                              <option value="${group.id!}" <#if (group.id?? && student.groupId?? && group.id == student.groupId)>selected</#if>>${group.name!}</option>
                                            </#list>
                                      </select>
                                      <a href="javascript:;" data-id="${student.id}" data-name="${student.nickname}" class="input-group-addon"><i class="fa fa-check"></i></a>
                                    </div>
	                            </td>
	                             <td> <a  class="btn power success"  data-student-id="${student.id}" href="javascript:;">
				                          <i class="fa fa-check"></i> 授权
				                        </a>
				                 </td>
	                        </tr>
	                    </#list>
	                </tbody>
	            </table>
	        </div>
		</div> 
         -->
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->
	<script>
	 $("#file-0d").fileinput({
        theme: 'fa',
        uploadUrl: '${base}/admin/teacher/upload', // you must set a valid URL here else you will get an error
        allowedFileExtensions: ['xls'],
        overwriteInitial: false,
        maxFileSize: 1000,
        maxFilesNum: 10,
        //allowedFileTypes: ['image', 'video', 'flash'],
    });
	</script>
	
  
   
		
</body>

</html>