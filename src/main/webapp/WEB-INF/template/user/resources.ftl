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
        
           <div class="container" style = "width:970px">
            <#include "/common.ftl">
            用户名：${user.username}，昵称：${user.nickname}
            <hr>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>资源名称</th>
                        <th>资源 url</th>
                        <th>资源权限字符串</th>
                    </tr>
                </thead>
                <tbody>
                    <#list resources as res>
                        <tr>
                            <td>${res.name}</td>
                            <td>${res.url}</td>
                            <td>${res.permission}</td>
                        </tr>
                    </#list>

                </tbody>
            </table>
        </div>
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

</body>

</html>