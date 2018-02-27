<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
	<script src="${base}/resources/bootstrap-3.3.0/js/answerPercent.js"></script>
	
</head>

<body>

<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">
 <br/>
		<div id="page-wrapper">
			     <div class="form-group">
			       <div class="col-sm-12 form-group">
			       <div class="panel-heading">
								<h3><span class="label label-middle label-success">各组成绩列表</span></h3>
					<hr>
					</div>
					 <div class="panel-heading">
								<h3><span class="label label-middle label-success">排名</span></h3>
							              <select name="order" id="order" class="form-control select2">
	                                       <option value="0.0">  排名   </option>
	                                        <option value="1"> - 总分排名 - </option>
	                                        <option value="2"> - 时间排名 - </option>
	                                       </select>
					</div>
					</div>
				    <table class="table table-striped" style="text-align:center">
	                <thead>
	                    <tr>
	                        <th style="text-align:center">组名</th>
	                        <th style="text-align:center">时间得分</th>
	                         <th width="180px">
	                         <div class="input-group">
	                                      <select name="timePercent"  class="form-control select2"   data-placeholder="时间所在比">
	                                        <option value="0.0">  时间所占比   </option>
	                                        <option value="0.1"> - 10% -</option>
	                                        <option value="0.2">- 20% -</option>
                                            <option value="0.3">- 30% -</option>
                                            <option value="0.4">- 40% -</option>
	                                      </select>
	                                      <a href="javascript:;" class="input-group-addon"><i class="fa fa-check"></i></a>
	                                    </div>      
	                        </th>
	                        <th style="text-align:center">答案得分</th>
	                        <th width="180px">
	                         <div class="input-group">
	                                      <select name="answerPercent"  class="form-control select2" data-field="studentId"  data-placeholder="答案所占比">
	                                        <option value="0.0"> 答案所占比</option>
                                            <option value="0.5">- 50% -</option>
                                            <option value="0.6">- 60% -</option>
                                            <option value="0.7">- 70% -</option>
                                            <option value="0.8">- 80% -</option>
                                            <option value="0.9">- 90% -</option>
	                                      </select>
	                                      <a href="javascript:;" class="input-group-addon"><i class="fa fa-check"></i></a>
	                                    </div>      
	                        </th>
	                        <th style="text-align:center">最后得分</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <#list scoreList as group>
	                        <tr role="row" 
							 >  
	                            <td>${group.groupName!}</td>
	                            <td>${group.timeScore!}</td>
	                            <td>${group.timePre!}</td>
	                            <td>${group.answerScore!}</td>
	                            <td>${group.answerPre!}</td>
	                            <td>${group.totalScore!}</td>
	                        </tr>
	                    </#list>
	                </tbody>
	            </table>
	               </div>
			     </div>
		     </div>
		 </div>
	</div>
		
		<script>
		 $("select[name=order]").change(function(){
            var name = $(this).val();
            var url = "${base}/teacher/estimateScore";
            $.ajax({
	    		type:"POST",
	    	    url:url,
	    	    contentType:"application/x-www-form-urlencoded",
	    	    dataType:'json',
	    	    data: {
	    	    	  "name": name,
	    	    },
	    	    success:function(data){
	    	    	if(data.code == "0"){
	    	    		alert("设置成功");
	    	    		window.location.reload();
	    	    	}else{
	    	    		alert("服务器错误");
	    	    	}
	    	    },
	    	    error:function(message){
	    	    	console.info(message);
	    	    }
	    	});
	    	 window.location.reload();
        });
        	
		</script>
</body>

</html>