<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
</head>
<script src="${base}/resources/bootstrap-3.3.0/js/teacherPower.js"></script>
<body>

	<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">

		<div id="page-wrapper">
		
           <div class="container" style = "height:170px">
           <br>
           <br>
              <div class="form-group">
                <label class="control-label col-md-2">授权项</label>
                  <div class="col-md-9">
                    <div class="form-control" style = "height:130px">
                        <ul class="list-unstyled">
                          <#list powerList as power>
                            <li class="col-md-4 no-space">
                              <label title="${power.name!}" class="col-md-12 no-space" style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;max-width: 100%">
                                <input data-original-value="0" type="checkbox" name="powerList" value="${power.id!}">
                                ${power.name!}
                              </label>
                            </li>
                          </#list>
                        </ul>
                    </div>
                    <span class="help-block">请选择授权项</span>
                  </div>
                  <div class="col-md-3">
                    <label class="col-md-8 no-space">
                      <input type="checkbox" name="selectAll" value="1">
                                                                全选
                    </label>
                  </div>
                   <div class="col-md-3">
                      <button type="button"  data-student-id= ${studentId} class="btn teacherPower btn-primary">确定授权</button>
                  </div>
              </div>
              
	       </div>
	       </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->
	
	
   
		
</body>

</html>