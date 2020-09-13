<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>预约挂号记录</title>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
    <script type="text/javascript" src="../js/common.js"></script>
</head>

<body>
<div class="c-main pb15 appoin">
    <h4>就诊人：<span id="name">*</span><span id="cardNo">（ 就诊卡号：* ）</span></h4>
    <div class="appolist">
        <ul>
        </ul>

        <div class="noData" hidden="true"
             style="position: absolute;top: 50%;left: 50%;margin-top: -50px;margin-left: -76.5px;">
            <img style="width: 153px;height: 100px;" src="../images/nodata.png">
            <p style="margin-top: 10px;width: 153px;text-align: center;color: #eeeeee;">暂无记录</p>
        </div>
    </div>
</div>
<div class="selectbg">
    <div class="selectextbg">
        <div class="selectext">
            <h4><span>取消</span>选择就诊人</h4>
            <ul>
            </ul>
        </div>
    </div>
</div>
<div class="c-conf-screen" hidden="true">
    <div class="c-conf-box">
        <div class="confcontent">是否要取消预约？</div>
        <div class="c-confbtn"><a href="javascript:;" class="c-twobtn cancel" id="popcanclebtn">取消</a><a href="javascript:;" class="c-twobtn comfirm" id="popsurebtn">确定</a></div>
    </div>
</div>


<div class="addpsonpop" hidden="true">
    <div class="addpson forremind">
        <i class="sicon icon-anclose" onclick="addpsonpopclose()"></i>
        <i class="an-remind"></i>
        <div class="h50 c-999 c-f15">你还未绑定任何就诊人</div>
        <a href="../user/memberList" class="btn-anadd mt10">去绑定</a>
    </div>
    <div class="addpson-mb"></div>
</div>
<script>
    var firsDayOfMonth = "";
    var currDay = "";
    $(function () {
        firsDayOfMonth = this.fun_date(-15);
        currDay = this.fun_date(7);
        $('.selectbg').hide();
        queryPatients();

        $("i.icon-anclose").click(function(){
            $('.addpsonpop').hide();
            window.history.back();
        })
    });



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

    function addpsonpopclose() {
        $(".addpsonpop").hide();
    }

    //获取就诊人列表
    function queryPatients() {
        var json = {
            "id": window.localStorage.getItem("openId"),
            "synUserName": "",
            "synKey": ""
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/queryPatients",
                dataParam: JSON.stringify(json)
            },
            success: function (result) {
                if (result != null) {
                    if (result.resultCode === "成功") {
                        if (result.myIdList !== null) {
                            var list = result.myIdList;
                            if (list.length > 0) {
                                $('#name').text(list[0].Name);
                                $('#cardNo').text("(就诊卡号"+list[0].CardNo+","+list[0].PatientNo+")");
                                queryReg(list[0]);
                                $.each(result.myIdList, function (i, item) {
                                    var data = JSON.stringify(item)
                                    $('.selectext ul').append("<li onclick='queryReg(" + data + ")'>" + item.Name + "</li>")
                                });
                                return
                            }
                        }
                    }
                }
                $('.addpsonpop').show();
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }

    function queryReg(item) {
        $('.appolist ul').html("");
        $(".selectbg").hide();
        $(".noData").hide();
        $('#name').text(item.Name);
        $('#cardNo').text("(就诊卡号"+item.CardNo+",门诊号"+item.PatientNo+")");
        var json = {
            "synUserName": "",
            "synKey": "",
            "CardNo": item.CardNo,
            "startDate": firsDayOfMonth,
            "endDate": currDay
        };
        $.ajax({
            url: "../his/request",
            method: "POST",
            dataType: 'json',
            data: {
                api: "/QueryReg",
                dataParam: JSON.stringify(json)
            },
            success: function (result) {
                if (result != null) {
                    if (result.resultCode ==='00') {
                        if (result.returnList !== null) {
                            console.log(result);
                            if (result.returnList.length > 0) {
                                $('#noData').hide();
                                $.each(result.returnList, function (i, item) {
                                    if(item.sourceTimeType=="1"){
                                        var sourceTimeType="上午";
                                    }else if(item.sourceTimeType=="2"){
                                        var sourceTimeType="中午";
                                    }else if(item.sourceTimeType=="3"){
                                        var sourceTimeType="下午";
                                    }else if(item.sourceTimeType=="4"){
                                        var sourceTimeType="晚上";
                                    }else if(item.sourceTimeType=="5"){
                                        var sourceTimeType="凌晨";
                                    }
                                    var sourceDate = item.sourceDate;
                                    var sourceDate = sourceDate.substring(0,sourceDate.length-8);
                                   // var sourceDate = Format(sourceDate,"yyyy-MM-dd");
                                    var data = JSON.stringify(item);
                                    $('#noData').show();
                                    if(item.payType=="9"){
                                        $('#noData').hide();
                                        if(item.regStatus=="1"){
                                            if(item.taketheNo=="0"){
                                                $('.appolist ul').append("<li>\n" +
                                                        "                <h5>患者姓名：" + item.patientName + "</h5>\n" +
                                                        "                <h5>预约日期："+sourceDate+"&nbsp;&nbsp;&nbsp;&nbsp;"+sourceTimeType+"</h5>\n" +
                                                        "                 <cite>挂号费用：" + item.consultationFee + "元</cite>\n" +
                                                        "                <em>挂号科室：" + item.LocationName + "</em><i\n" +
                                                        "                <em>医生：" + item.DoctorName + "</em><i\n" +
                                                        "id='" + item.CardNo + "' onclick='delPatient("+data+")' class=\"defaubq\">取消预约</i></div>\n" +
                                                        "                <span>"+"预约成功"+"</span>\n" +
                                                        "            </li>")
                                            }else {
                                                $('.appolist ul').append("<li>\n" +
                                                        "                <h5>患者姓名：" + item.patientName + "</h5>\n" +
                                                        "                <h5>预约日期："+sourceDate+"&nbsp;&nbsp;&nbsp;&nbsp;"+sourceTimeType+"</h5>\n" +
                                                        "                 <cite>挂号费用：" + item.consultationFee + "元</cite>\n" +
                                                        "                <em>挂号科室：" + item.LocationName + "</em><i\n" +
                                                        "                <em>医生：" + item.DoctorName + "</em>\n" +
                                                        "                <span>"+ "预约成功,已取号"+"</span>\n" +
                                                        "            </li>")
                                            }
                                        }else{
                                            if(item.regStatus=="2"){
                                                $('.appolist ul').append("<li>\n" +
                                                        "                <h5>患者姓名：" + item.patientName + "</h5>\n" +
                                                        "                <h5>预约日期："+sourceDate+"&nbsp;&nbsp;&nbsp;&nbsp;"+sourceTimeType+"</h5>\n" +
                                                        "                 <cite>挂号费用：" + item.consultationFee + "元</cite>\n" +
                                                        "                <em>挂号科室：" + item.LocationName + "</em><i\n" +
                                                        "                <em>医生：" + item.DoctorName + "</em>\n" +
                                                        "                <span>"+ "已取消"+"</span>\n" +
                                                        "            </li>")
                                            }else if(item.regStatus=="3"){
                                                $('.appolist ul').append("<li>\n" +
                                                        "                <h5>患者姓名：" + item.patientName + "</h5>\n" +
                                                        "                <h5>预约日期："+sourceDate+"&nbsp;&nbsp;&nbsp;&nbsp;"+sourceTimeType+"</h5>\n" +
                                                        "                 <cite>挂号费用：" + item.consultationFee + "元</cite>\n" +
                                                        "                <em>挂号科室：" + item.LocationName + "</em><i\n" +
                                                        "                <em>医生：" + item.DoctorName + "</em>\n" +
                                                        "                <span>"+ "已就诊"+"</span>\n" +
                                                        "            </li>")
                                            }else if (item.regStatus=="4"){
                                                $('.appolist ul').append("<li>\n" +
                                                        "                <h5>患者姓名：" + item.patientName + "</h5>\n" +
                                                        "                <h5>预约日期："+sourceDate+"&nbsp;&nbsp;&nbsp;&nbsp;"+sourceTimeType+"</h5>\n" +
                                                        "                 <cite>挂号费用：" + item.consultationFee + "元</cite>\n" +
                                                        "                <em>挂号科室：" + item.LocationName + "</em><i\n" +
                                                        "                <em>医生：" + item.DoctorName + "</em>\n" +
                                                        "                <span>"+"已过期"+"</span>\n" +
                                                        "            </li>")
                                            }

                                        }
                                    }
                                });
                                return;
                            }
                        }
                    }
                }
                $('.noData').show();
            },
            error: function (e) {
                $.toast("获取失败，请稍后再试!");
            }
        });
    }
    function delPatient(data) {
        $('.c-conf-screen').show();

        $(".cancel").click(function () {
            $('.c-conf-screen').hide();
        });
        $('.comfirm').click(function () {
            var json = {
                synUserName:  "",
                synKey: "",
                sourceMark:data.sourceMark,
                patientNo:data.CardNo,
                sourceDate:data.sourceDate,
                departmentorganId:data.departmentorganId
            };
            $.ajax({
                url: "../his/request",
                method: "POST",
                dataType: 'json',
                data: {
                    api: "/doregcancel",
                    dataParam: JSON.stringify(json)
                },
                success: function (result) {
                    console.log(result);
                    if (result != null) {
                        if (result.resultCode === "00") {
                            $('.c-conf-screen').hidden="true";
                            $.ajax({
                                url: "../pay/refundPay",
                                method: "POST",
                                dataType: 'json',
                                data: {
                                    refund_id: data.consultationFee,
                                   // refund_id: "0.01",
                                    transaction_id:data.payNo
                                },
                                success: function (result) {
                                    if (result != null) {
                                        if (result.code == 'SUCCESS') {
                                            var data = JSON.stringify(result.data);
                                            $.toast("取消预约成功!");
                                            window.location.href = '../user/reservationRecord'
                                            return
                                        }
                                    }
                                },
                                error: function (e) {

                                }
                            });
                        }
                    }
                    location.reload();
                },
                error: function (e) {
                    $.toast("取消预约失敗!");
                }
            });
        });
    }

//    function getFirsDayOfMonth() {
//        var date = new Date();
//        date.setDate(1);
//        return this.timeFormate(date)
//    }
//
//    function getCurrDay() {
//        var date = new Date();
//        var h = date.getHours();
//        var s = date.getSeconds();
//        var m = date.getMinutes()+1;
//        return this.timeFormateMonth(date)
//    }
//
//    function timeFormateMonth(date) {
//        if (!date || typeof (date) === "string") {
//            this.error("参数异常，请检查...")
//        }
//        var y = date.getFullYear();
//        var m = date.getMonth() + 2;
//        var d = date.getDate();
//        return y + "-" + m + "-" + d
//
//    }

</script>
</body>
</html>