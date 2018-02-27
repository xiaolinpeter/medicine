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
	<script src="${base}/resources/bootstrap-3.3.0/js/submitCheck.js"></script>
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
              
	    
	    <form enctype="multipart/form-data" id= "uploadForm" >
			        <hr>
			        <div class="form-group">
			            <div class="file-loading">
			                <input id="file-0d" class="file" type="file"  name="image">
			            </div>
			        </div>
			        <hr><!--   
			        
			         <button type="button" class="btn upload btn-primary">Submit</button>
			         <button type="reset" class="btn btn-default">Reset</button>
			         
			        -->
			        
        </form>
            <div class="form-group">
              <div class="col-sm-12">
		     	<ul id="myTab" class="nav nav-tabs">
				   <li class="active"><a href="#home" data-toggle="tab">
				     待审核</a></li>
				   <li><a href="#doing" data-toggle="tab">审核中</a></li>
				   <li><a href="#finish" data-toggle="tab">审核完成</a></li>
				 </ul>
		        </div>
        </div>
		  <div id="myTabContent" class="tab-content">
		      <div class="tab-pane fade in active" id="home">
			     <div class="form-group">
			       <div class="col-sm-12 form-group">
				  <table class="table table-striped">
	                <thead>
	                    <tr>
	                        <th>文件id</th>
	                        <th>文件名</th>
	                        <th>审核</th>
	                        <th>操作</th>
	                    </tr
	                </thead>
	                <tbody>
	                    <#list fileList as file>
	                        <tr role="row"><!--    <td><input type="checkbox"  name="ids"  value="${file.id!}"></td> -->
	                          
	                            <td>${file.id?substring(0,4)}</td>
	                            <td>${file.name!}</td>
	                            <td>
	                                   <#if (file.isSubmit == 0)>
		                               	    <a data-entity-id="${file.id!}"  data-update-status-value="1" class="btn btn-xs success" href="javascript:;">
					                          <i class="fa fa-check"></i> 提交审核
					                        </a>
				                        <#elseif (file.isSubmit ==1)> 
					                        <a data-entity-id="${file.id!}"  data-update-status-value="0" class="btn btn-xs primary" href="javascript:;">
					                         <i class="fa fa-close"></i> 取消提交
					                        </a>
				                        </#if>
	                            </td>
	                             <td>
	                             <a href="${base}/admin/teacher/download?name=${file.name}">下载</a>
	                             删除
	                              </td>
	                             
	                        </tr>
	                    </#list>
	                </tbody>
	            </table>
	               </div>
			     </div>
		     </div>
		   
			   <div class="tab-pane fade" id="doing">
			     <div class="form-group">
			       <div class="col-sm-12 form-group">
			         <table class="table table-striped">
	                <thead>
	                    <tr>
	                        <th>文件id</th>
	                        <th>文件名</th>
	                        <th>状态</th>
	                        <th>操作</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <#list fileInCheckList as file>
	                        <tr role="row"><!--    <td><input type="checkbox"  name="ids"  value="${file.id!}"></td> -->
	                          
	                            <td>${file.id?substring(0,4)}</td>
	                            <td>${file.name!}</td>
	                            <td>
				                   <span class="label label-sm label-primary">审核中</span>
	                            </td>
	                             <td>
	                             <a href="${base}/admin/teacher/download?name=${file.name}">下载</a>
	                             删除
	                              </td>
	                             
	                        </tr>
	                    </#list>
	                </tbody>
	            </table>
			      </div>
			    </div>
			  </div>
		  
		  
		     <div class="tab-pane fade" id="finish">
			     <div class="form-group">
			       <div class="col-sm-12 form-group">
			         <table class="table table-striped">
	                <thead>
	                    <tr>
	                        <th>文件id</th>
	                        <th>文件名</th>
	                        <th>状态</th>
	                        <th>操作</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <#list fileInCheckList as file>
	                        <tr role="row"><!--    <td><input type="checkbox"  name="ids"  value="${file.id!}"></td> -->
	                          
	                            <td>${file.id?substring(0,4)}</td>
	                            <td>${file.name!}</td>
	                            <td>
				                  <#if (file.checkStatus == 1)>
				                         <span class="label label-sm label-success">通过</span>                        
	                               <#else>
				                         <span class="label label-sm label-warning">未通过</span>                        
	                               </#if>
	                            </td>
	                             <td>
	                             <a href="${base}/admin/teacher/download?name=${file.name}">下载</a>
	                             删除
	                              </td>
	                             
	                        </tr>
	                    </#list>
	                </tbody>
	            </table>
			      </div>
			    </div>
			  </div>
		  
		  
		 </div>
	</div>
	<!-- /#wrapper -->
	<script>
	 $("#file-0d").fileinput({
        theme: 'fa',
        uploadUrl: '${base}/admin/teacher/uploadFile', // you must set a valid URL here else you will get an error
        allowedFileExtensions: ['xls','word'],
        overwriteInitial: false,
        maxFileSize: 1000,
        maxFilesNum: 10,
        //allowedFileTypes: ['image', 'video', 'flash'],
    });
	</script>
	
    
   
		
</body>

</html>