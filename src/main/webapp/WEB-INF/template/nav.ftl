<#assign base = request.contextPath>
<!-- Navigation -->

	<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0">
			
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target=".navbar-collapse">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="${base}/index.html"><b>教学辅助平台管理系统</b></a>
	</div>
			<!-- /.navbar-header -->
			
			<ul class="nav navbar-top-links navbar-right">
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="${base}/logout" aria-expanded="true">
					    ${loginUser.nickname}<i class="fa fa-user fa-fw"></i> <i
							class="fa fa-caret-down"></i>
					</a>
						<ul class="dropdown-menu dropdown-user">
							<li><a href="${base}/setting.html"><i
									class="fa fa-toggle-on fa-fw"></i> 个人设置 </a></li>
							<li class="divider"></li>
							<li><a href="${base}/logout"><i
									class="fa fa-sign-out fa-fw"></i> 退出登录 </a></li>
						</ul> <!-- /.dropdown-user --></li>
					<!-- /.dropdown -->
			</ul>
			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">
						 <#list userResourceList as resource>
							<!-- 一级子菜单没有parentId,有url -->  
					           <li><a href="#">${resource.name!}
					           <#if (resource.children??)>
					              <span class="fa arrow"></span>
					           </#if></a>
					    
					         		<ul class="nav nav-second-level">
					         		<#if (resource.children??)>
						         	  <#list resource.children as secondChild>
								         	 <li>
								         	      <#if (secondChild.url?substring(secondChild.url?length-2) == "**") >
    											      <#if (secondChild.isMenu == 1)>
    											       <a href="#">${secondChild.name!}
    											           <#if (secondChild.children??)>
    											                 <span class="fa arrow">
    											           </#if>
    											         </a>
    											        </#if>
											       <#else>  
											         <#if (secondChild.isMenu == 1)> 
											          <a href="${base}${secondChild.url}">${secondChild.name!}
                                                           <#if (secondChild.children??)>
                                                                 <span class="fa arrow">
                                                          </#if>
                                                       </#if>
                                                      </a>
                                                   </#if>
											       <#if (secondChild.children??)>
        													 <ul class="nav nav-third-level">
        															  <#list secondChild.children as thirdChild>
        															     <li>
        															         <#if (thirdChild.isMenu == 1)>
		        															     <a href="${base}${thirdChild.url!}">${thirdChild.name!}
		        															       <#if (thirdChild.children??)>
	                                                                                  <span class="fa arrow">
	                                                                               </#if>
	                                                                               </a> 
			        															   <#if (thirdChild.children??)>
			                                                               					   <ul class="nav nav-fourth-level">
				                                                               					    <#list thirdChild.children as fourthChild>
				                                                               					     <#if (fourthChild.isMenu == 1)>
				                                                               					         <li><a href="${base}${fourthChild.url!}">${fourthChild.name!}</a></li>
				                                                               					     </#if>
				                                                               					     </#list>
				                                                               				  </ul>
			                                                                      </#if>
		                                                                       </#if>
        															     </li>
        															 </#list> 
        										 			 </ul>
												   </#if>
										       </li>
							          </#list>	
							         </#if>  
                                      </ul>
                                 </li>	
                      </#list> 
				   </ul>      
				</div>
				<!-- /.sidebar-collapse -->
			</div>
			<!-- /.navbar-static-side -->
		</nav>