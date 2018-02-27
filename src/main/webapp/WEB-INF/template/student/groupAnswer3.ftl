<#assign base =request.contextPath >
<html>
<head>
<title>完整demo</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script type="text/javascript" charset="utf-8" src="${base}/resources/sbadmin/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${base}/resources/sbadmin/ueditor/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${base}/resources/sbadmin/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" charset="utf-8" src="${base}/resources/sbadmin/ueditor/editor.js"></script>

<style type="text/css">
div {
    width: 100%;
}
</style>
</head>
<body>
    <div>
        <h1>完整demo</h1>
        <script id="editor" type="text/plain"
            style="width:1024px;height:500px;"></script>
    </div>
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