<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
<script src="${base}/resources/bootstrap-3.3.0/js/dividePage.js"></script>
</head>

<body>

    <div id="wrapper">

        <!-- 侧边导航和banner -->
        <#include "/nav.ftl">

        <div id="page-wrapper">
        
        <div class="container" style="width:970px">
            <#include "/common.ftl">
            <span>${role.name}（${role.sn}）的拥有的权限有：</span>
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

                // 为复选框设置单击事件
                $(".resourceId").on("click",function(){
                    var c = 0;
                    var ifChecked = this.checked
                    if(ifChecked){
                        c = 1;
                    }
                    var roleId = "${role.id}";
                    var resourceId = $(this).val();
                    $.post("${base}/admin/role/resource",{
                        "roleId":roleId,
                        "resourceId":resourceId,
                        "check":c
                    },function(data){
                        if(data.success){
                            var ctext = c==0 ? "权限取消成功":"权限绑定成功";
                            alert(ctext);
                        }else{
                            alert(data.errorInfo);
                        }
                    });
                });
            })
        </script>
</body>

</html>