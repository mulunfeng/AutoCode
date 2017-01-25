<!DOCTYPE html>
<html>
<head>
    <title>${model.tableRemarks}列表</title>
    <meta charset="UTF-8">
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/style.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/js/jquery.pagination/pagination.css"/>
    <script src="/js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="/js/jquery.pagination/jquery.pagination.js"></script>
    <script src="/js/layer/layer.js"></script>
    <!-- 日期选择 -->
    <script type="text/javascript" src="/plugins/datepicker/dateRange.js"></script>
    <script type="text/javascript" src="/plugins/datepicker/monthPicker.js"></script>
    <link rel="stylesheet" type="text/css" href="/plugins/datepicker/dateRange.css"/>
    <link rel="stylesheet" type="text/css" href="/plugins/datepicker/monthPicker.css"/>
    <script type="text/javascript">
        var dateRange;

        function add${entity}(){
            location.href = "/toAdd${entity}.html";
        }

        function del${entity}(id){
            var url =  "/del${entity}.html?id=" + id ;
            $.ajax({ url: url, type : "GET",  dataType:"text", success: function(data){
                if (data != null){
                    layer.msg('已删除!');
                    $("#queryForm").submit();
                }
            }});
        }

        function clearInput(){
            $("#platform").val("");
            $("#title").val("");
            $("#endTimeBegin").val("");
            $("#endTimeEnd").val("");
        }

        function search(){
            $("#pageNumber").val(1);
            $("#queryForm").submit();
        }
    </script>
</head>
<body>

<div class="ibox float-e-margins">
    <div class="ibox-title">
        <h5>活动管理</h5>
    </div>
    <form method="post" id="queryForm" action="/${entity?uncap_first}List.html">
        <input type="hidden" value="$!{page.pageVO.pageNumber}" id="pageNumber" name="pageNumber">
        <div class="row" style="width: 100%;">
            <div class="col-sm-10" style="float:left;width: 100%;">
                <div class="input-group" style="float:left;width:5%;margin:0 2px;">
                    <span class="input-group-btn">
                        <button type="button" onclick="search();" class="btn btn-primary">搜索</button>
                    </span>
                    &nbsp;
                    <span class="input-group-btn">
                        <button type="button" onclick="clearInput();" class="btn btn-primary">清空</button>
                    </span>
                    &nbsp;
                     <span class="input-group-btn">
                        <button type="button" onclick="add${entity}();" class="btn btn-primary">添加</button>
                    </span>
                </div>
            </div>
        </div>
    </form>
    <div class="ibox-content">
        <table class="table table-bordered" style="table-layout:fixed;;word-break:break-all;;border-collapse:collapse">
            <thead>
                <tr>
                <th width="${100/(model.columns?size+2)}%">序号</th>
                <#list model.columns as field>
                    <#if !(field.columnKey)??>
                    <th width="${100/(model.columns?size+2)}%"><#if field.comments?if_exists!="">${field.comments}<#else>${field.javaName}</#if></th>
                    </#if>
                </#list>
                    <th width="${100/(model.columns?size+2)}%">操作</th>
                </tr>
            </thead>
            <tbody>
                #set($pages=1)
                #foreach($item in $page.listResult)
                    <tr>
                    <td>$pages</td>
                    <#list model.columns as field>
                        <#if !(field.columnKey)??>
                            <#if field.dataType == "Date">
                        <td>$!dateTool.format("yyyy-MM-dd HH:mm:ss",$!{item.${field.javaName}})</td>
                             <#else>
                        <td>$!{item.${field.javaName}}</td>
                             </#if>
                        </#if>
                    </#list>
                        <td>
                            <a data-toggle="modal" class="btn btn-primary btn-sm" href="toUpdate${entity}.html?id=$!{item.${model.columnKey.javaName}}">修改</a>
                            <a data-toggle="modal" class="btn btn-primary btn-sm" onclick="del${entity}($!{item.id});" id="del${entity}" woolId="$!{item.${model.columnKey.javaName}}" href="#">删除</a>
                        </td>
                    </tr>
                    #set($pages=$pages+1)
                #end
            </tbody>
        </table>
    </div>
</div>

#if(${r'#${'}page})
<div class="fixed-table-pagination" style="display: block;">
    <div class="pull-left pagination-detail"><b>总记录数：#if($!{page.pageVO.totalCount})$!{page.pageVO.totalCount} #else 0#end</b></div>
    <div id="page_div" class="pull-right pagination"></div>
</div>
#end

<br>
<script type="text/javascript">
    $("#page_div").pagination($!{page.pageVO.totalPage}, {
        current_page: $!{page.pageVO.pageNumber}-1,
        num_edge_entries: 3,
        num_display_entries: 3,
        items_per_page: 1,
        link_to: "javascript:;",
        ellipse_text: "...",
        prev_text: "上一页",
        next_text: "下一页",
        prev_show_always: true,
        next_show_always: true,
        callback: function (pageNumber) {//在翻页时候用的
            if ((pageNumber + 1) != jQuery("#pageNumber").val()) {
                jQuery("#pageNumber").val(pageNumber + 1);
                jQuery("#queryForm").submit();
            }
        }
    });
</script>
</body>
</html>