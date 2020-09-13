<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>检验报告详情</title>
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
    <div class="appolist" style="overflow-y:auto;">
        <ul>

        </ul>
    </div>
</div>

<script>

    $(function () {
        $.showPreloader('加载中...');
        getQueryString();
        patientNo = getQueryString("patientNo");
        endDate = getQueryString("endDate");
        startDate = getQueryString("startDate");
        submitInfoOut();
    });
    var patientNo=null;
    var endDate=null;
    var startDate=null;


    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURI(r[2]);
        return null;
    }

    function submitInfoOut() {
        var json = {
            "synUserName": "",
            "synKey": "",
            "patientNo":patientNo,
            "startDate":startDate,
            "endDate":endDate
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/queryexaminationrecordlist",
                dataParam: JSON.stringify(json)
            },
            success: function (result) {
                console.log(result);
                if (result != null) {
                    if (result.resultCode === "00") {
                        if (result.hisReport !== null) {
                            $('.appolist ul').empty();
                            $.each(result.hisReport, function (i, item) {
                                var data = JSON.stringify(item);
                                var reportType = item.reportType;
                                var report = "";
                                if(reportType == 1){
                                    report = "检验";
                                }else if(reportType == 2){
                                    report = "B超";
                                }else if(reportType == 3){
                                    report = "放射影像";
                                }else if(reportType == 4){
                                    report = "内镜";
                                }else if(reportType == 5){
                                    report = "病理";
                                }else if(reportType == 6){
                                    report = "心电图";
                                }
                                var reportStatus = item.reportStatus;
                                var status = "";
                                if(reportStatus == 0){
                                    status = "未出报告";
                                }else if(reportStatus == 1){
                                    status = "已出报告";
                                }
                                $('.appolist ul').append("<li onclick='details("+data+")'>\n" +
                                        "                <h5>检查名称:" + item.checkName + "</h5>\n" +
                                        "                <em>报告编号：" + item.reportNo + "</em>\n" +
                                        "                <em>患者姓名：" + item.patientName + "</em>\n" +
                                        "                <em>报告状态：" + status + "</em>\n" +
                                        "                <em>报告的类型：" + report + "</em>\n" +
                                        "                <em>检查医生：" + item.chekckdoctorName + "</em>\n" +
                                        "                <em>出报告医生：" + item.doctorName + "</em>\n" +
                                        "                <em>检查时间：" + item.reportDate + "</em>\n" +
                                        "                <em>医生建议：" + item.impression + "</em>\n" +
                                        "            </li>")
                            });
                            $('.appolist ul').show();
                            return;
                        }
                        $('.appolist ul').empty();
                    }
                    $.toast(result.resultMsg);
                }
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }


    function details(data) {
        var reportNo=data.reportNo;
        window.location.href = '../registration/queryExaminationRecordDetails?patientNo=' + patientNo +"&startDate="+startDate
                +"&endDate="+endDate  +"&reportNo="+reportNo ;
    }


</script>
</body>
</html>