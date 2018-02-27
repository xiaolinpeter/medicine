<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
</head>

<body>

    <div id="wrapper">

        <!-- 侧边导航和banner -->
        <#include "/nav.ftl">

        <div id="page-wrapper">
        
        <div class="container" style="width:970px">
            <#include "/common.ftl">
            <span>${role.name}的拥有的权限有：</span>
                 <#list hasResourceIds as hasResourceId>
                       <input type="hidden" class="hasResourceId" value="${hasResourceId}"/>
                 </#list>
            <table class="table table-striped" id="dataTables-example">
                <thead>
                    <tr>
                        <th>权限标识</th>
                        <th>权限名称</th>
                        <th>权限 url</th>
                        <th>资源权限字符串</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <#list resourceList as resource>
                        <tr>
                            <td>${resource.id}</td>
                            <td>${resource.name}</td>
                            <td>${resource.url}</td>
                            <td>${resource.permission}</td>
                            <td>
                                <input type="checkbox" class="resourceId" value="${resource.id}">
                            </td>
                        </tr>
                    </#list>
                </tbody>
            </table>
               <button type="button"  class="btn resource btn-primary">保存权限</button>
        </div>
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
         <script type="text/javascript">
            $(function(){

                // 为角色所绑定的资源进行显示设置 begin
                var resourceArray = new Array();
                $(".hasResourceId").each(function(){
                    var hasResource = $(this);
                    resourceArray.push(hasResource.val());
                });

                $(".resourceId").each(function(){
                    var resource = $(this);
                    if($.inArray(resource.val(),resourceArray) >= 0){
                        resource.attr("checked","checked");
                    }
                });
                // 为角色所绑定的资源进行显示设置 end

                // 保存权限
                  $(".resource").on("click",function(){
					var resourceIdList = [];
					var roleId = "${role.id}";
					var resourceList = $('input[type = "checkbox"]:checked');
                    resourceList.each(function(){
                        resourceIdList.push($(this).prop('value'));
                    });
                    var url = "${base}/admin/role/resource";
                    $.ajax({
                        type:'POST',
                        url :url,
                        dataType : 'json',
                        traditional :true, 
                        data:{
                         "roleId": roleId,
                         "resourceIdList" : resourceIdList
                        },success:function(data){
                            if(data.code == '200') {
                            alert("设置成功");
                              window.location.reload();
                            }
                        },error:function(data){
                            alert("设置失败");
                        }
                        
                    
                    });
                  });
                  
            })
        </script>
</body>

</html>