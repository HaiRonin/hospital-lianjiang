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
    <div style="display: flex;flex-direction: column;border-radius: 5px;padding: 8px;font-size: 14px; ">
        <div class="card"
             style="display: flex;flex-direction: column;border-radius: 5px;padding: 8px;font-size: 14px; ">
            <div style="height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;">
                <span style="width: 40%">检查名称:</span>
                <span id="checkName" style="width: 60%;"></span>
            </div>
            <div style="height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;">
                <span style="width: 50%">报告编号:</span>
                <span id="reportNo" style="width: 50%;text-align: right;"></span>
            </div>
            <div style="height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;">
                <span style="width: 40%">患者姓名:</span>
                <span id="patientName" style="width: 60%;text-align: right;"></span>
            </div>
            <div style="height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;">
                <span style="width: 40%">报告状态:</span>
                <span id="status" style="width: 60%;text-align: right;"></span>
            </div>
            <div style="height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;">
                <span style="width: 40%">报告的类型:</span>
                <span id="report" style="width: 60%;"></span>
            </div>
            <div style="height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;">
                <span style="width: 40%">检查医生:</span>
                <span id="chekckdoctorName" style="width: 60%;"></span>
            </div>
            <div style="height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;">
                <span style="width: 40%">出报告医生:</span>
                <span id="doctorName" style="width: 60%;"></span>

            </div>
            <div style="height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;">
                <span style="width: 40%">检查时间:</span>
                <span id="reportDate" style="width: 60%;"></span>

            </div>
            <div style="line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;">
                <span style="width: 40%">医生建议:</span>
                <span id="impression" style="width: 60%;"></span>
            </div>
        </div>
    </div>
    <div class="appolist" style="overflow-y:auto;">
        <div class="listInfo">
            <div> <h5><input style="width: 3%;visibility:hidden"><span >检验项目:</span><input style="width: 25%;visibility:hidden"><input style="width: 35%;visibility:hidden"><span >结果(参考值)</span>
            </h5>
                <ul>
                </ul>
            </div>

        </div>
    </div>
</div>

<script>

    $(function () {
        $.showPreloader('加载中...');
        getQueryString();
        patientNo = getQueryString("patientNo");
        endDate = getQueryString("endDate");
        startDate = getQueryString("startDate");
        reportNo = getQueryString("reportNo");
        queryexaminationrecordlist();
    });
    var patientNo=null;
    var endDate=null;
    var startDate=null;
    var reportNo=null;

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURI(r[2]);
        return null;
    }

    function queryexaminationrecordlist() {
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
                if (result != null) {
                    if (result.resultCode === "00") {
                        if (result.hisReport !== null) {
                            $('.appolist ul').empty();
                            $.each(result.hisReport, function (i, item) {
                                if(reportNo == item.reportNo){
                                    var data = JSON.stringify(item);
                                    console.log(data);
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
                                    $('#reportNo').text(item.reportNo );
                                    $('#patientName').text(item.patientName );
                                    $('#status').text(status);
                                    $('#report').text(report);
                                    $('#chekckdoctorName').text(item.chekckdoctorName );
                                    $('#doctorName').text(item.doctorName );
                                    $('#reportDate').text(item.reportDate );
                                    $('#impression').text(item.impression );

                                    $.each(item.reportContent , function (i, item1) {
                                        var data1 = JSON.stringify(item1);
                                        console.log(data1);
                                        var result=item1.reportValue.split("<|>");

                                        var  result1 = null;
                                        var  result2 = null;
                                        var  result3 = null;
                                        var  result4 = null;
                                        var  result5 = null;

                                            console.log(result);
                                              result1=result[0];
                                        var result6=result1.split("(")[0];
                                              result2=result[1];
                                              result3=result[2];
                                              result4=result[3];
                                        var result7=result4.split("(")[0];
                                              result5=result[4];
                                        $(".listInfo ul").append("<li class=\"islink\">\n" +
                                                "<div style=\"height: 40px;line-height:40px;display: flex;flex-direction: row; border-bottom: #eeeeee 1px solid;\">"+
                                                " <div  style=\"text-align:left; \">" + result6 + "</div>"+
                                                " <span >" + result2+"("+ result7 +")"+ "</span>"+
                                                        "</div>"+
                                                "            </li>")

                                    });

                                }
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

</script>
</body>
</html>