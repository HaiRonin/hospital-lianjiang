<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>检验报告</title>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
    <script type="text/javascript" src="../js/common.js"></script>
    <link rel="stylesheet" href="../js/laydate/theme/default/laydate.css" id="layuicss-laydate">
    <script type='text/javascript'  src="../js/laydate/laydate.js" charset='utf-8'></script>
</head>
<body>
<div class="c-main pb15 appoin">
    <#--<h4>就诊人：<span id="name"></span><span id="cardNo"></span>-->
    <#--</h4>-->
    <div class="appolist" style="overflow-y:auto;">
        <input style="width: 5%;visibility:hidden">
        <input type="text" class="demo-input" placeholder="开始日期" id="test1" style="width: 27%;height:30px;">
        <input style="width: 3%;visibility:hidden">
        <input type="text" class="demo-input" placeholder="结束日期" id="test2" style="width: 27%;height:30px;">
        <input style="width: 5%;visibility:hidden">
        <#--<input style="width: 25%; height:30px;border-radius:10px; color: #007aff" placeholder="确定" onclick="submitInfoOut()">-->
        <button style="width: 25%; height:30px;border-radius:10px;color: #1a1a1a;background-color: #007aff" onclick="submitInfoOut()">确定</button>
        <ul>
        </ul>
    </div>
</div>
<script>
    laydate.render({
        elem: '#test1' //指定元素
    });
    laydate.render({
        elem: '#test2' //指定元素
    });
    $().ready(function(){
        var height = ($(window).height()-70) + "px";
        $(".appolist").css("height",height);
    });
    $.showPreloader('加载中...');
    var firsDayOfMonth = "";
    var currDay = "";
    $(function () {
        firsDayOfMonth = this.fun_date(-30);
       currDay = this.fun_date(1);
        $('.selectbg').hide();
        Name = getQueryStringInfo("Name");
        CardNo = getQueryString("CardNo");
        IDCardno = getQueryString("IDCardno");
        querypaymentrecordlist();

    });

    function getQueryStringInfo(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURI(r[2]); return null;
    }

    var Name=null;
    var IDCardno=null;
    var CardNo=null;

    $(".appoin h4").click(function () {
        $(".selectbg").show();
    });

    $(".selectext h4 span").click(function () {
        $(".selectbg").hide();
    });

    $(".selectext ul li").click(function () {
        var selecttext = $(this).html();
        $(".appoin h4 span").html(selecttext);
        $(".selectbg").hide();
    });

    function querypaymentrecordlist() {
        $(".selectbg").hide();

        $("input#test").val();
        var json1 = {
            "synUserName": "",
            "synKey": "",
            "cardNo":IDCardno,
        };
        $('.appolist ul').hide();
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/querypatientinfobyidno",
                dataParam: JSON.stringify(json1)
            },
            success: function (result1) {
                console.log(result1);
                if (result1 != null) {
                    if (result1.resultCode === "00") {
                        $('#name').text(Name);
                        //$('#cardNo').text("(门诊ID号" + CardNo + ")");
                       // $('#cardNo').text("(就诊卡号"+item.CardNo+",门诊号"+result1.patientNo+")");
                        patientNo = result1.patientNo;
                    }
                }
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }
    var patientNo=null;


    function submitInfoOut() {
        var startDate =$("#test1").val();
        var endDate=$("#test2").val();
        if(startDate==''||startDate==null){
            $.toast("请选择开始时间!");
            return ;
        }
        if(endDate==''||endDate==null){
            $.toast("请选择结束时间!");
            return ;
        }

        window.location.href = '../registration/queryExaminationRecord?patientNo=' + patientNo +"&startDate="+startDate
                +"&endDate="+endDate;
    }

</script>
</body>
</html>