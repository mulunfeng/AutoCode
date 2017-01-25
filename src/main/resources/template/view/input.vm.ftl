<!DOCTYPE html>
<html>
<head>
    <title>添加${model.tableRemarks}</title>
    <meta charset="UTF-8">

    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.min.css" rel="stylesheet">
    <script src="/js/jquery-1.11.3.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/content.min.js"></script>
    <script src="/js/layer/laydate/laydate.js"></script>
    <script src="/js/layer/layer.js"></script>
    <script type="text/javascript">
        function initError() {
            #if($errorMsg)
                #foreach($item in $errorMsg)
                    $("input[name=$item.field]").after("<span style='color: firebrick'>$item.defaultMessage.replaceAll('"',"'")</span>");
                #end
            #end

            #if($errorMsgInfo)
                alert('$errorMsgInfo');
            #end
        }

        //输入框前后空格
        $(document).ready(function() {
            $('#add${entity} input').blur(inputblurtrim);
        });
        function inputblurtrim() {
            lucene_objInput = $(this);
            var im = $.trim(lucene_objInput.val());
            lucene_objInput.val(im);
        }

    </script>
</head>
<body class="gray-bg" onload="initError();">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="ibox float-e-margins">
            <div class="ibox-content">
                <form action="/add${model.entityName}.html" id="add${model.entityName}" method="post" class="form-horizontal">
                <#list model.columns as field>
                    <#if field.columnKey??>
                    <input type="hidden" name="${field.javaName}" value="${r'$!{'}${model.entityName?uncap_first}.${field.javaName}}">
                    <#else>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><#if field.comments?if_exists!="">${field.comments}<#else>${field.javaName}</#if><#if !field.nullable><label style="color:red">*</label></#if></label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="${field.javaName}" value="${r'$!{'}${model.entityName?uncap_first}.${field.javaName}}" <#if !field.nullable>required="true"</#if>>
                        </div>
                    </div>
                    </#if>
                </#list>

                    <div class="hr-line-dashed"></div>

                    <div class="form-group">
                        <div class="col-sm-4 col-sm-offset-2">
                            <button class="btn btn-primary" type="submit">保存内容</button>
                            <button class="btn btn-white" type="button" onclick="javascript:location.href='${model.entityName?uncap_first}List.html';">取消</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="/js/jquery-1.11.3.min.js"></script>
<script src="/js/jquery.validate.min.js"></script>
<script src="/js/jquery.metadata.js"></script>
<script src="/js/messages_zh.min.js"></script>
<script src="/js/jquery.validate.methods.js"></script>
<script src="/js/layer/laydate/laydate.js"></script>
<script>
    $(document).ready(function() {
        $("#add${model.entityName}").validate();
    });
</script>
</body>
</html>