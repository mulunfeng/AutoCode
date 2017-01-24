<!DOCTYPE html>
<html>
<head>
    <title>title</title>
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

        function clearInput(){
            $("#platform").val("");
            $("#title").val("");
            $("#endTimeBegin").val("");
            $("#endTimeEnd").val("");
            //日期选择器清空
            $("#"+dateRange.inputId).html("<span style='font-size: 10px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>")
//            $("#reviewStatus").get(0).selectedIndex = "";
            $("#displayFlag").get(0).selectedIndex = "";
            $("#woolType").get(0).selectedIndex = "";
            $("#expire").get(0).selectedIndex = "";
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
    <form method="post" id="queryForm" action="/${model.entityName?uncap_first}List.html">
        <input type="hidden" value="$!{page.pageVO.pageNumber}" id="pageNumber" name="pageNumber">
        <div class="row">
            <div class="col-sm-10" style="float:left;">
                <div class="input-group m-b" style="float:left;width:15%;margin:0 5px;">
                    <input placeholder="平台" name="platform" class="form-control layer-date" id="platform" value="$!{${model.entityName?uncap_first}.platform}">
                </div>
                <div class="input-group m-b" style="float:left;width:15%;margin:0 5px;">
                    <input placeholder="活动标题" name="title" class="form-control layer-date" id="title" value="$!{${model.entityName?uncap_first}.title}">
                </div>
                <div class="input-group m-b" style="float:left;width:10%;margin:0 5px;">
                    <select class="form-control m-b" name="woolType" id="woolType" >
                        <option value="">类型</option>
                        #foreach($param in ${WoolTypeEnum.keySet()})
                        #if( $!{param} == $!{woolVO.woolType})
                        <option selected="selected" value="$!{param}">$!{WoolTypeEnum.get($param)}</option>
                        #else
                        <option value="$!{param}">$!{WoolTypeEnum.get($param)}</option>
                        #end
                        #end
                    </select>
                </div>
                ##                <div class="input-group m-b" style="float:left;width:10%;margin:0 5px;">
                ##                    <select class="form-control m-b" name="reviewStatus" id="reviewStatus" >
                ##                        <option value="">认证状态</option>
                ##                        #foreach($param in ${AuthenticationEnum.keySet()})
                ##                            #if( $!{param} == $!{woolVO.reviewStatus})
                ##                                <option selected="selected" value="$!{param}">$!{AuthenticationEnum.get($param)}</option>
                ##                            #else
                ##                                <option value="$!{param}">$!{AuthenticationEnum.get($param)}</option>
                ##                            #end
                ##                        #end
                ##                    </select>
                ##                </div>
                <div class="input-group m-b" style="float:left;width:105px;margin:0 5px;">
                    <select class="form-control m-b" name="displayFlag" id="displayFlag" >
                        <option value="">是否显示</option>
                        #foreach($param in ${DisplayEnum.keySet()})
                        #if( $!{param} == $!{woolVO.displayFlag})
                        <option selected="selected" value="$!{param}">$!{DisplayEnum.get($param)}</option>
                        #else
                        <option value="$!{param}">$!{DisplayEnum.get($param)}</option>
                        #end
                        #end
                    </select>
                </div>
                <div class="input-group m-b" style="float:left;width:270px;margin:0 0 0 5px;">
                    <input type="hidden" name="endTimeBegin" id="endTimeBegin" value="$!dateTool.format("yyyy-MM-dd HH:mm:ss",$!{woolVO.endTimeBegin})">
                    <input type="hidden" name="endTimeEnd" id="endTimeEnd" value="$!dateTool.format("yyyy-MM-dd HH:mm:ss",$!{woolVO.endTimeEnd})">
                    <div class="ta_date" id="div_date_demo3">结束时间
                        <span class="date_title" id="date_demo3"></span>
                        <a class="opt_sel" id="input_trigger_demo3" href="#">
                            <i class="i_orderd"></i>
                        </a>
                    </div>
                    <div id="datePicker"></div>
                    <br/>
                    <script type="text/javascript">
                        dateRange = new pickerDateRange('date_demo3', {
                            aRecent7Days : 'aRecent7DaysDemo3', //最近7天
                            isTodayValid : true,
                            startDate : '$!dateTool.format("yyyy-MM-dd",$!{woolVO.endTimeBegin})',
                            endDate : '$!dateTool.format("yyyy-MM-dd",$!{woolVO.endTimeEnd})',
                            //needCompare : true,
                            //isSingleDay : true,
                            //shortOpr : true,
                            defaultText : ' 至 ',
                            inputTrigger : 'input_trigger_demo3',
                            theme : 'ta',
                            success : function(obj) {
                                $("#endTimeBegin").val(obj.startDate+" 00:00:00");
                                $("#endTimeEnd").val(obj.endDate+" 00:00:00");
                            }
                        });
                        if ($("#"+dateRange.inputId).html() == null || $("#"+dateRange.inputId).html() == ""){
                            $("#"+dateRange.inputId).html("<span style='font-size: 10px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>")
                        }
                    </script>
                </div>
                <div class="input-group m-b" style="float:left;width:105px;">
                    <select class="form-control m-b" name="expire" id="expire" >
                        <option value="">是否过期</option>
                        #foreach($param in ${YesNoEnum.keySet()})
                        #if( $!{param} == $!{woolVO.expire})
                        <option selected="selected" value="$!{param}">$!{YesNoEnum.get($param)}</option>
                        #else
                        <option value="$!{param}">$!{YesNoEnum.get($param)}</option>
                        #end
                        #end
                    </select>
                </div>
                <div class="input-group" style="float:left;width:5%;margin:0 5px;">
                    <span class="input-group-btn">
                        <button type="button" onclick="search();" class="btn btn-primary">搜索</button>
                    </span>
                    &nbsp;
                    <span class="input-group-btn">
                        <button type="button" onclick="clearInput();" class="btn btn-primary">清空</button>
                    </span>
                    &nbsp;
                     <span class="input-group-btn">
                        <button type="button" onclick="addWool();" class="btn btn-primary">添加</button>
                    </span>
                </div>
            </div>
        </div>
    </form>
    <div class="ibox-content">
        <table class="table table-bordered" style="table-layout:fixed;;word-break:break-all;;border-collapse:collapse">
            <thead>
            <tr>
                <th width="3%">序号</th>
                <th width="7%">平台</th>
                <th width="14%">活动标题</th>
                <th width="22%">活动内容</th>
                <th width="9%">活动类型</th>
                <th width="90px;">活动开始时间</th>
                <th width="90px;">活动结束时间</th>
                <th width="8%">已过期</th>
                <th width="11%">活动条件</th>
                <th width="17%">链接</th>
                <th width="4%">排序值</th>
                ##                    <th width="7%">认证状态</th>
                <th width="90px;">创建时间</th>
                <th width="4%">是否显示</th>
                <th width="10%">操作</th>
            </tr>
            </thead>
            <tbody>
            #set($pages=1)
            #foreach($item in $page.listResult)
            <tr>
                <td>$pages</td>
                <td>$!{item.platform}</td>
                <td><a href="/showWool.html?id=$!{item.id}">$!{item.title}</a></td>
                <td>$!{item.context}</td>
                <td>
                    #if($!{item.woolType})
                    $WoolTypeEnum.get($!{item.woolType})
                    #end
                </td>
                <td>$!dateTool.format("yyyy-MM-dd HH:mm:ss",$!{item.startTime})</td>
                <td>$!dateTool.format("yyyy-MM-dd HH:mm:ss",$!{item.endTime})</td>
                <td>
                    #if($!item.endTime.getTime() < $!now.getTime())
                    已过期
                    #else
                    未过期
                    #end
                </td>
                <td>$!{item.woolCondition}</td>
                <td>$!{item.orignUrl}</td>
                <td>$!{item.ind}</td>
                ##                        <td>
                ##                            #if($!{item.reviewStatus})
                ##                                $AuthenticationEnum.get($!{item.reviewStatus})
                ##                            #end
                ##                            #if(!${item.reviewStatus})
                ##                                未认证
                ##                            #end
                ##                        </td>
                <td>$!dateTool.format("yyyy-MM-dd HH:mm:ss",$!{item.createTime})</td>
                <td>$DisplayEnum.get($!{item.displayFlag})</td>
                <td>
                    <a data-toggle="modal" class="btn btn-primary btn-sm" href="toUpdateWool.html?id=$!{item.id}">修改</a>
                    <a data-toggle="modal" class="btn btn-primary btn-sm" onclick="displayWool($!{item.id});" id="delWool" woolId="$!{item.id}" href="#">
                        #if($!{item.displayFlag} == 1)$DisplayEnum.get(0)#end #if($!{item.displayFlag} == 0)$DisplayEnum.get(1)#end
                    </a>
                    ##                            #if(!${item.reviewStatus} || $!{item.reviewStatus} == 0 )
                    ##                                <a data-toggle="modal" class="btn btn-primary btn-sm" onclick="checkWool($!{item.id});" href="#">认证</a>
                    ##                            #end
                </td>
            </tr>
            #set($pages=$pages+1)
            #end
            </tbody>
        </table>
    </div>
</div>

#if(${page})
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