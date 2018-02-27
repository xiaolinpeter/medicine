<#assign base = request.contextPath>
<html>
<head>
<#include "/head.ftl">
	<script src="${base}/resources/bootstrap-3.3.0/js/editTask.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/answer.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/deleteBatch.js"></script>
	<script src="${base}/resources/bootstrap-3.3.0/js/deleteBatch.js"></script>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <script type="text/javascript" charset="utf-8" src="${base}/resources/sbadmin/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${base}/resources/sbadmin/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="${base}/resources/sbadmin/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" charset="utf-8" src="${base}/resources/sbadmin/ueditor/editor.js"></script>
    <!--
       <script src="${base}/resources/bootstrap-3.3.0/js/submit.js"></script> 
     -->
	
</head>

<body>

	<div id="wrapper">

		<!-- 侧边导航和banner -->
		<#include "/nav.ftl">

		<div id="page-wrapper">
		
         <div class="container">
	          <form id="form" action="${base}/student/groupSubmit" class="form-horizontal form-bordered">
	          <div class="form-group hidden">
                <label class="control-label col-md-2">标题</label>
                <div class="col-md-9">
                  <div class="input-icon right">
                    <i class="fa fa-warning tooltips hidden"></i>
                    <input type="hidden"  name="problemId" maxlength="50" value="${problem.id}" class="form-control" readonly = "readonly"/>
                  </div>
                </div>
              </div>
              
             <div class="form-group">
                <label class="control-label col-md-2">标题</label>
                <div class="col-md-9">
                  <div class="input-icon right">
                    <i class="fa fa-warning tooltips hidden"></i>
                    <input type="text"  name="title" maxlength="50" value="${problem.title}" class="form-control" readonly = "readonly"/>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label class="control-label col-md-2">答案</label>
                <div class="col-md-9">
                        <script id="editor" name="answer" type="text/plain"
                            style="height:500px;"></script>
                </div>
              </div>
              
              <div class="form-actions">
                <div class="row">
                  <div class="col-md-offset-2 col-md-10">
                    <button type="submit" class="btn  blue"><i class="fa fa-check"></i>保存</button>
                    <button type="button" name="back" data-id= "${problem.id}" class="btn default"><i class="fa fa-reply"></i>返回</button>
                  </div>
                </div>
              </div>
            </div>
          </form>
	        </div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->
	  <#--
      <div id="btns">
        <div>
            <button onclick="getAllHtml()">获得整个html的内容</button>
            <button onclick="getContent()">获得内容</button>
            <button onclick="setContent()">写入内容</button>
            <button onclick="setContent(true)">追加内容</button>
            <button onclick="getContentTxt()">获得纯文本</button>
            <button onclick="getPlainTxt()">获得带格式的纯文本</button>
            <button onclick="hasContent()">判断是否有内容</button>
            <button onclick="setFocus()">使编辑器获得焦点</button>
            <button onmousedown="isFocus(event)">编辑器是否获得焦点</button>
            <button onmousedown="setblur(event)">编辑器失去焦点</button>

        </div>
        <div>
            <button onclick="getText()">获得当前选中的文本</button>
            <button onclick="insertHtml()">插入给定的内容</button>
            <button id="enable" onclick="setEnabled()">可以编辑</button>
            <button onclick="setDisabled()">不可编辑</button>
            <button onclick=" UE.getEditor('editor').setHide()">隐藏编辑器</button>
            <button onclick=" UE.getEditor('editor').setShow()">显示编辑器</button>
            <button onclick=" UE.getEditor('editor').setHeight(300)">设置高度为300默认关闭了自动长高</button>
        </div>

        <div>
            <button onclick="getLocalData()">获取草稿箱内容</button>
            <button onclick="clearLocalData()">清空草稿箱</button>
        </div>

    </div>
    <div>
        <button onclick="createEditor()">创建编辑器</button>
        <button onclick="deleteEditor()">删除编辑器</button>
    </div>
    
    -->
   
		
</body>

</html>