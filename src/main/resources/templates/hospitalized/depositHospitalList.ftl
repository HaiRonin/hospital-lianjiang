<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="format-detection" content="telephone=no"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <title>押金缴纳记录</title>
    <link rel="stylesheet" href="../css/kdui/min.css">
    <script type='text/javascript' src='../js/min.js' charset='utf-8'></script>
    <script type='text/javascript' src='../js/polyfill/min.js' charset='utf-8'></script>
    <link rel="stylesheet" href="../css/base.css" type="text/css"/>
    <link rel="stylesheet" href="../css/qlcstyle.css" type="text/css"/>
    <script type="text/javascript" src="../js/common.js"></script>
</head>
<body>
<div class="c-main pb15 appoin">
    <h4>就诊人：<span id="name"></span><span id="cardNo"></span>
        </h4>

    <div class="list-block" style="margin: 0;font-size: 14px;">
        <ul>
            <li class="item-content" style="padding-left: 0;min-height: auto;height: 35px;line-height: 35px">
                <div class="item-media"><i class="icon icon-f7"></i></div>
                <div class="item-inner">
                    <div class="item-title">总费用：</span></div>
                    <div id="totalMoney" class="item-after"></div>
                </div>
            </li>
        </ul>
    </div>

    <div class="appolist" style="overflow-y:auto;">
        <ul>
        </ul>
        <div id="noData" hidden="true"
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
            <ul style="overflow:auto;">
            </ul>
        </div>
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
<div class="addInHosNo" hidden="true">
    <div class="addpson forremind">
        <i class="sicon icon-anclose" onclick="addInHosNoclose()"></i>
        <i class="an-remind"></i>
        <div class="h50 c-999 c-f15">你还未绑定住院号</div>
        <a href="../user/memberList" class="btn-anadd mt10">去绑定</a>
    </div>
    <div class="addpson-mb"></div>
</div>

<script>
    $().ready(function(){
        var height = ($(window).height()-110) + "px";
        $(".appolist").css("height",height);
    });
    $.showPreloader('加载中...');
    var firsDayOfMonth = "";
    var currDay = "";
    $(function () {
        firsDayOfMonth = this.fun_date(-30);
        currDay = this.fun_date(1);
        $('.selectbg').hide();
        queryPatients();
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
                                $('#name').text(list[list.length - 1].Name);
                                $('#cardNo').text("(住院号" + list[list.length - 1].inHosNo + ")");
                                querypaymentrecordlist(list[list.length - 1]);
                            }
                            $.each(result.myIdList, function (i, item) {
                                var data = JSON.stringify(item);
                                $('.selectext ul').append("<li onclick='querypaymentrecordlist(" + data + ")'>" + item.Name + "</li>")
                            });
                            return
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

    function addpsonpopclose() {
        $(".addpsonpop").hide();
    }

    function addInHosNoclose() {
        $(".addInHosNo").hide();
    }

    function querypaymentrecordlist(item) {
        $(".selectbg").hide();
        var json1 = {
            "synUserName": "",
            "synKey": "",
            "cardNo":item.IDCardno,
        };
        $('.appolist ul').hide();
        $('#totalMoney').text("0.00元");
        if(item.inHosNo==null || item.inHosNo==''){
            $.toast("无住院信息");
            $('#noData').show();
            $('.addInHosNo').show();
            return
        }
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
                        $('#name').text(item.Name);
                        $('#cardNo').text("(住院号" + item.inHosNo + ")");
                        var json = {
                            "inHosNo": item.inHosNo,
                            "synUserName": "",
                            "synKey": "",
                            "patientNo":result1.patientNo,

                            "startDate":firsDayOfMonth,
                            "endDate":currDay
                        };
                        $.ajax({
                            url: "../his/request",
                            method: "POST",
                            dataType: 'json',
                            data: {
                                api: "/paydetail",
                                dataParam: JSON.stringify(json)
                            },
                            success: function (result) {
                                console.log(result);
                                if (result != null) {
                                    if (result.resultCode === "00") {
                                        if (result.payList !== null) {
                                            $('#noData').hide();
                                            $('.appolist ul').empty();
                                            var totalMoney = 0;
                                            $.each(result.payList, function (i, item) {
                                                totalMoney += item.payMoney;
                                                var payMoney = item.payMoney == 0 ? '0.00元':item.payMoney.toFixed(2)+"元";
                                                var payType = "银联";
                                                if(item.payType == 1){
                                                    payType = "银联";
                                                }else if(item.payType == 2){
                                                    payType = "支付宝";
                                                }else if(item.payType == 3){
                                                    payType = "现场支付";
                                                }else if(item.payType == 4){
                                                    payType = "医保账户";
                                                }else if(item.payType == 5){
                                                    payType = "微信";
                                                }else if(item.payType == 6){
                                                    payType = "建行";
                                                }else if(item.payType == 7){
                                                    payType = "中行";
                                                }else if(item.payType == 8){
                                                    payType = "社保卡支付";
                                                }
                                                $('.appolist ul').append("<li>\n" +
                                                        "                <h5>住院流水号：" + item.inHosSerialNo + "</h5>\n" +
                                                        "                <em>预缴金金额：" + payMoney + "</em>\n" +
                                                        "                <em>发票号：" + item.invoiceNo + "</em>\n" +
                                                        "                <em>支付方式：" + payType + "</em>\n" +
                                                        "                <em>缴费时间：" + item.payDate + "</em>\n" +
                                                        "                <em>操作员：" + item.operatorNo + "</em>\n" +
                                                        "            </li>")
                                            });
                                            $('#totalMoney').text(totalMoney.toFixed(2) + "元");
                                            $('.appolist ul').show();
                                            return;
                                        }
                                        $('.appolist ul').empty();
                                        $('#noData').show();
                                    }
                                    $('#noData').show();
                                }

                            },
                            error: function (e) {
                                $.toast("获取失败，请稍后再试!");
                            }
                        });


                    }
                    $.toast("无住院信息");
                    $('#noData').show();
                    $('.addInHosNo').show();
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