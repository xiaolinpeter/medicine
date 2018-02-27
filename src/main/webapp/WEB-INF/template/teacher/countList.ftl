<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
	<script src="${base}/resources/bootstrap-3.3.0/js/count.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/allocate.js"></script>
	
</head>

<body>

<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">

		<div id="page-wrapper">
	    <br/>
	    <div class="panel-heading">
				<h3><span class="label label-middle label-success">抢答情况</span></h3>
				<hr>
		</div>
            <div class="form-group">
              <div class="col-sm-12">
		     	<ul id="myTab" class="nav nav-tabs">
				   <li class="active"><a href="#home" data-toggle="tab">
				     已抢到小组</a></li>
				   <li><a href="#finish" data-toggle="tab">未抢到小组</a></li>
				 </ul>
		        </div>
        </div>
		  <div id="myTabContent" class="tab-content">
		      <div class="tab-pane fade in active" id="home">
			     <div class="form-group">
			       <div class="col-sm-12 form-group">
				    <table class="table table-striped" style="text-align:center">
	                <thead>
	                    <tr>
	                        <th style="text-align:center">组名</th>
	                        <th style="text-align:center">组长</th>
	                        <th style="text-align:center">题目</th>
	                        <th style="text-align:center">答案是否提交</th>
	                        <th style="text-align:center">操作</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <#list answerList as answer>
	                        <tr role="row" 
								data-id="${answer.problemId}" data-title="${answer.problemName!}"
								 data-answer="${answer.reallyAnswer!}" data-groupId = ${answer.groupId!} data-score="${answer.answerScore!}">
								<td>${answer.groupName!}</td>
	                            <td>${answer.studentName!}</td>
	                            <td>${answer.problemName}!</td>
	                            <td><#if (answer.submitFlag?? &&  answer.submitFlag== 0)>
	                            <span class="label label-warning">未提交<span>    
	                                 <#else>
                                 <span class="label label-success">已提交
                                   <#if (answer.scoreSubmitFlag?? && answer.scoreSubmitFlag == 1)>
	                                         <span class="label label-primary">已评分 </span> 
	                                      <#else>
	                                         <span class="label label-danger">未评分  </span> 
	                                     </#if> 
                                 <span> 
	                                 </#if>                                                 
	                            </td>
	                             <td><#if (answer.submitFlag??  &&  answer.submitFlag == 0)>
	                                 <#else>
	                                       <a data-toggle="modal" class="btn btn-primary"  href="#detail-modal-form"><i class="fa fa-search"></i>查看答案详情 </a>
	                                    <#if (answer.scoreSubmitFlag?? && answer.scoreSubmitFlag == 1)>
	                                         <a data-toggle="modal" class="btn btn-success"  href="#score-modal-form">查看评分</a>
	                                    <#else>
	                                      <a data-toggle="modal" class="btn btn-warning"  href="#timeScore-modal-form">立刻评分</a>
	                                    </#if>
	                             </#if>                                                 
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
			          <table class="table table-striped" style="text-align:center">
	                <thead>
	                    <tr>
	                        <th style="text-align:center">组名</th>
	                        <th style="text-align:center">组长</th>
	                        <th>分配题目</th>
	                        <th style="text-align:center">答案是否提交</th>
	                        <th style="text-align:center">操作</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <#list groupList as group>
	                        <tr role="row" 
	                            data-group-id="${group.id!}"
								data-allocateAnswer="${group.answer!}" 
								data-allocateTitle="${group.allocateTitle!}"
								data-reallyScore = "${group.reallyScore!}">
								<td>${group.name}</td>
	                            <td>${group.leaderName}</td>
	                             <td> <div class="input-group" style="width:280px;">
	                                      <select name="questionId"  class="form-control select2" data-field="studentId"  data-placeholder="选择组号">
	                                        <option value="">题目</option>
	                                            <#list group.questionList as question>
	                                              <option value="${question.id!}" <#if (group.questionId?? && question.id?? && group.questionId == question.id)>selected</#if>>${question.title!}</option>
	                                            </#list>

	                                      </select>
	                                      <a href="javascript:;" data-id="${group.id!}"  class="input-group-addon"><i class="fa fa-check"></i></a>
	                                    </div>                                             
	                            </td>
	                             <td><#if (group.submitFlag?? && group.submitFlag == 1)>
	                                   <span class="label label-success">已提交  
	                                     <#if (group.scoreFlag?? && group.scoreFlag == 1)>
	                                         <span class="label label-primary">已评分 </span> 
	                                      <#else>
	                                         <span class="label label-warning">未评分  </span> 
	                                     </#if> 
	                                     </span> 
	                                 <#else>
                                       <span class="label label-warning">未提交<span> 
	                                 </#if>                                                 
	                            </td>
	                             <td><#if (group.submitFlag?? && group.submitFlag == 1)>
                                  <a data-toggle="modal" class="btn btn-primary"  href="#allocate-modal-form"><i class="fa fa-search"></i>查看答案详情 </a>
	                                    <#if (group.scoreFlag?? && group.scoreFlag == 1)>
	                                     <a data-toggle="modal" class="btn btn-success"  href="#allocateScore-modal-form">查看评分</a>
	                                    <#else>
	                                      <a data-toggle="modal" class="btn btn-success"  href="#timeAllocateScore-modal-form">立刻评分</a>
	                                    </#if>
	                             </#if>                                                 
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
	
	<div class="modal fade" id="detail-modal-form" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <form class="form-horizontal" action="" role="form" method="post" autocomplete="off">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h4 class="modal-name">答案详情</h4>
          </div>
          <div class="modal-body">
             <div class="form-body">
              <div class="form-group">
					<label class="col-sm-2 control-label">题目</label>
					<div class="col-sm-10">
						<input type="text" name="title" placeholder="请输入题目"
							class="form-control">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-2 control-label">答案</label>
					<div class="col-sm-10">
                                  <textarea name="answer" class="form-control" rows="8"></textarea>
					</div>
				</div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn default" data-dismiss="modal" >关闭 </button>
          </div>
        </form>
      </div>
    </div>
   </div>
   
   
   <div class="modal fade" id="allocate-modal-form" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
      <form class="form-horizontal" action="" role="form" method="post" autocomplete="off">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h4 class="modal-name">答案详情</h4>
          </div>
          <div class="modal-body">
             <div class="form-body">
              <div class="form-group">
					<label class="col-sm-2 control-label">题目</label>
					<div class="col-sm-10">
						<input type="text" name="allocateTitle" placeholder="请输入组名"
							class="form-control">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-2 control-label">答案</label>
					<div class="col-sm-10">
                                  <textarea name="allocateAnswer" class="form-control" rows="8"></textarea>
					</div>
				</div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn default" data-dismiss="modal" > 关闭 </button>
          </div>
           </form>
      </div>
    </div>
   </div>
   
   <div class="modal fade" id="score-modal-form" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
      <form class="form-horizontal" action="" role="form" method="post" autocomplete="off">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h4 class="modal-name">评分</h4>
          </div>
          <div class="modal-body">
             <div class="form-body">
              <div class="form-group hidden">
					<label class="col-sm-2 control-label">组号</label>
					<div class="col-sm-10">
                                 	<input type="text" name="groupId" placeholder="请输入组号"
							class="form-control">
					</div>
				</div>
				
              <div class="form-group">
					<label class="col-sm-2 control-label">题目</label>
					<div class="col-sm-10">
						<input type="text" name="title" placeholder="请输入标题"
							class="form-control">
					</div>
				</div>
				
				
				   <div class="form-group">
					<label class="col-sm-2 control-label">分数</label>
					<div class="col-sm-10">
						<input type="text" name="score" placeholder="请输入分数"
							class="form-control" >
					</div>
				</div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn default" data-dismiss="modal" > 关闭 </button>
          </div>
           </form>
      </div>
    </div>
   </div>
   
   
   <div class="modal fade" id="timeScore-modal-form" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
      <form class="form-horizontal" action="${base}/teacher/answerScore" role="form" method="post" autocomplete="off">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h4 class="modal-name">评分</h4>
          </div>
          <div class="modal-body">
             <div class="form-body">
              <div class="form-group hidden">
					<label class="col-sm-2 control-label">组号</label>
					<div class="col-sm-10">
                    <input type="text" name="groupId" placeholder="请输入组号"
							class="form-control">
					</div>
				</div>
				
              <div class="form-group">
					<label class="col-sm-2 control-label">题目</label>
					<div class="col-sm-10">
						<input type="text" name="title" placeholder="请输入标题"
							class="form-control">
					</div>
				</div>
				
				
				   <div class="form-group">
					<label class="col-sm-2 control-label">分数</label>
					<div class="col-sm-10">
						<input type="text" name="score" placeholder="请输入分数"
							class="form-control" >
					</div>
				</div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn default" > 确定 </button>
            <button type="button" class="btn default" data-dismiss="modal" > 关闭 </button>
          </div>
           </form>
      </div>
    </div>
   </div>
   
   
    <div class="modal fade" id="allocateScore-modal-form" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
      <form class="form-horizontal" action="" role="form" method="post" autocomplete="off">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h4 class="modal-name">评分</h4>
          </div>
          <div class="modal-body">
             <div class="form-body">
              <div class="form-group hidden">
					<label class="col-sm-2 control-label">组号</label>
					<div class="col-sm-10">
                                 	<input type="text" name="groupId" placeholder="请输入组号"
							class="form-control">
					</div>
				</div>
				
              <div class="form-group">
					<label class="col-sm-2 control-label">题目</label>
					<div class="col-sm-10">
						<input type="text" name="allocateTitle" placeholder="请输入标题"
							class="form-control">
					</div>
				</div>
				   <div class="form-group">
					<label class="col-sm-2 control-label">分数</label>
					<div class="col-sm-10">
						<input type="text" name="score" placeholder="请输入分数"
							class="form-control">
					</div>
				</div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn default" data-dismiss="modal" > 关闭 </button>
          </div>
           </form>
      </div>
    </div>
   </div>
   
   
     <div class="modal fade" id="timeAllocateScore-modal-form" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
      <form class="form-horizontal" action="${base}/teacher/answerScore" role="form" method="post" autocomplete="off">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h4 class="modal-name">评分</h4>
          </div>
          <div class="modal-body">
             <div class="form-body">
              <div class="form-group hidden">
					<label class="col-sm-2 control-label">组号</label>
					<div class="col-sm-10">
                                 	<input type="text" id="groupId" name="groupId" placeholder="请输入组号"
							class="form-control">
					</div>
				</div>
				
              <div class="form-group">
					<label class="col-sm-2 control-label">题目</label>
					<div class="col-sm-10">
						<input type="text" name="allocateTitle" placeholder="请输入标题"
							class="form-control">
					</div>
				</div>
				   <div class="form-group">
					<label class="col-sm-2 control-label">分数</label>
					<div class="col-sm-10">
						<input type="text" name="score" placeholder="请输入分数"
							class="form-control">
					</div>
				</div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn btn-success" > 确定 </button>
            <button type="button" class="btn default" data-dismiss="modal" > 关闭 </button>
          </div>
           </form>
      </div>
    </div>
   </div>
</body>

</html>